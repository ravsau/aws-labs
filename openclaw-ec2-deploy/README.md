# OpenClaw on EC2 — CLI-Only Deploy

Deploy your own AI assistant on AWS using only the terminal. No console. No key pairs.
No API keys. Under $15/month for light usage.

Uses the [aws-samples/sample-OpenClaw-on-AWS-with-Bedrock](https://github.com/aws-samples/sample-OpenClaw-on-AWS-with-Bedrock) CloudFormation template.

**What you get:** OpenClaw running on a Graviton EC2 instance, connected to Claude Haiku
via Amazon Bedrock, accessible via SSM tunnel. Connects to WhatsApp, Telegram, Discord,
Slack. Browses the web, runs code, manages tasks.

**Cost:** ~$15/month (light usage) to ~$30/month (heavy usage). No surprise bills.

---

## Prerequisites

### 1. AWS CLI v2

You need the AWS CLI installed and configured. If you already have it, skip ahead.

**Check if installed:**
```bash
aws --version
```

**Install (if needed):**

macOS:
```bash
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
rm AWSCLIV2.pkg
```

Linux:
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip
```

Windows:
```
Download and run: https://awscli.amazonaws.com/AWSCLIV2.msi
```

**Configure:**
```bash
aws configure
# Enter your Access Key ID, Secret Access Key, region (us-west-2), output format (json)
```

> Need an AWS CLI course? [AWS CLI Course on Udemy](https://www.udemy.com/course/aws-cli-course/?referralCode=16426B3D9228F18FD52A)

### 2. Bedrock Model Access

Enable Claude Haiku in the Bedrock console for your region (one-time, approval is instant):

```
https://console.aws.amazon.com/bedrock/home?region=us-west-2#/modelaccess
```

Request access to **Anthropic > Claude Haiku 4.5**.

### 3. SSM Session Manager Plugin

Installed in Step 1 below.

---

## How We Connect: SSM Session Manager (No SSH, No Key Pairs)

Traditional EC2 access means opening port 22, creating a key pair, and managing SSH.
This lab uses none of that. Instead we use **AWS Systems Manager Session Manager**.

**How it works:**
- The EC2 instance runs an SSM Agent (pre-installed on Amazon Linux and Ubuntu AMIs)
- The agent phones home to the SSM service over HTTPS (outbound only — no inbound ports needed)
- When you run `aws ssm start-session`, AWS creates an encrypted WebSocket tunnel between your machine and the instance
- Authentication is your IAM credentials — the same `aws configure` you already set up
- Every session is logged in CloudTrail (who connected, when, what they did)

**Why this is better than SSH:**
- No port 22 open in security groups (zero attack surface)
- No key pairs to create, rotate, or accidentally commit to GitHub
- No bastion hosts or VPNs needed
- Works even if the instance is in a private subnet with no public IP
- Port forwarding works too — that's how we access the OpenClaw web UI on localhost

The SSM plugin on your laptop is just a thin client that handles the WebSocket connection.
Install it once, use it for any EC2 instance going forward.

---

## Step 1: Install SSM Session Manager Plugin

One-time install. This is the client-side piece that lets your terminal talk to SSM.

**macOS:**
```bash
brew install --cask session-manager-plugin
```

**Linux (Ubuntu/Debian):**
```bash
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" \
  -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
rm session-manager-plugin.deb
```

**Windows:**
```powershell
# Download from:
# https://s3.amazonaws.com/session-manager-downloads/plugin/latest/windows/SessionManagerPluginSetup.exe
# Run the installer.
```

**Verify:**
```bash
session-manager-plugin --version
```

---

## Step 2: Clone the Template

```bash
git clone https://github.com/aws-samples/sample-OpenClaw-on-AWS-with-Bedrock.git
cd sample-OpenClaw-on-AWS-with-Bedrock
```

> **Important:** Always `git clone` — don't download the YAML manually.
> Manual downloads can corrupt the file encoding and CloudFormation will silently fail.

---

## Step 3: Deploy

One command. Takes ~8 minutes.

```bash
aws cloudformation create-stack \
  --stack-name openclaw \
  --template-body file://clawdbot-bedrock.yaml \
  --parameters \
    ParameterKey=InstanceType,ParameterValue=t4g.small \
    ParameterKey=OpenClawModel,ParameterValue=global.anthropic.claude-haiku-4-5-20251001-v1:0 \
    ParameterKey=CreateVPCEndpoints,ParameterValue=false \
  --capabilities CAPABILITY_IAM \
  --region us-west-2
```

**What this creates:**
- VPC with public/private subnets
- t4g.small EC2 instance (Graviton ARM, 2GB RAM, $12/month)
- IAM role with Bedrock access (no API keys needed)
- Security groups (no ports open — all access via SSM)
- OpenClaw installed and running automatically

**Wait for it to finish:**
```bash
aws cloudformation wait stack-create-complete \
  --stack-name openclaw \
  --region us-west-2
```

---

## Step 4: Connect

**Get the instance ID:**
```bash
INSTANCE_ID=$(aws cloudformation describe-stacks \
  --stack-name openclaw \
  --query 'Stacks[0].Outputs[?OutputKey==`InstanceId`].OutputValue' \
  --output text \
  --region us-west-2)

echo "Instance: $INSTANCE_ID"
```

**Start the tunnel (keep this terminal open):**
```bash
aws ssm start-session \
  --target $INSTANCE_ID \
  --document-name AWS-StartPortForwardingSession \
  --parameters '{"portNumber":["18789"],"localPortNumber":["18789"]}' \
  --region us-west-2
```

**In a new terminal — get your token and open the UI:**
```bash
TOKEN=$(aws ssm get-parameter \
  --name /openclaw/openclaw/gateway-token \
  --with-decryption \
  --query Parameter.Value \
  --output text \
  --region us-west-2)

echo "Open: http://localhost:18789/?token=$TOKEN"
```

Open that URL in your browser. You're in.

---

## Step 5: Use It

Once you're in the Web UI:

| Try this | What happens |
|----------|-------------|
| "What's the weather in Tokyo?" | Bedrock answers via Haiku |
| "Summarize this PDF" + attach | Document analysis |
| "Open google.com and search for X" | Web browsing |
| `/status` | See model, tokens used, cost |
| `/new` | Fresh conversation |

**Connect messaging apps:** Go to Settings > Channels. OpenClaw walks you through
connecting WhatsApp, Telegram, Discord, or Slack step by step.

---

## Cost Breakdown

| Component | Monthly |
|-----------|---------|
| EC2 t4g.small (Graviton ARM) | $12.00 |
| EBS 30GB gp3 | $2.40 |
| VPC Endpoints | $0 (disabled) |
| Haiku — light use (~10 convos/day) | $1-3 |
| Haiku — heavy use (~100 convos/day) | $8-15 |
| **Total (light)** | **~$15/mo** |
| **Total (heavy)** | **~$30/mo** |

Want to switch models later? Update the stack:
```bash
aws cloudformation update-stack \
  --stack-name openclaw \
  --template-body file://clawdbot-bedrock.yaml \
  --parameters \
    ParameterKey=InstanceType,UsePreviousValue=true \
    ParameterKey=OpenClawModel,ParameterValue=global.amazon.nova-2-lite-v1:0 \
    ParameterKey=CreateVPCEndpoints,UsePreviousValue=true \
  --capabilities CAPABILITY_IAM \
  --region us-west-2
```

Nova 2 Lite is $0.30 per million input tokens — 70% cheaper than Haiku.

---

## Available Models

| Model | Input / Output per 1M tokens | Best for |
|-------|------------------------------|----------|
| Claude Haiku 4.5 | $1.00 / $5.00 | Fast, cheap, good for daily use |
| Nova 2 Lite | $0.30 / $2.50 | Cheapest option |
| Nova Pro | $0.80 / $3.20 | Balanced |
| Claude Sonnet 4.5 | $3.00 / $15.00 | Complex reasoning |
| DeepSeek R1 | $0.55 / $2.19 | Open-source reasoning |
| Llama 3.3 70B | — | Open-source |

---

## Available Instance Types

| Type | Monthly | RAM | Notes |
|------|---------|-----|-------|
| t4g.small | $12 | 2GB | Cheapest. Fine for personal use. |
| t4g.medium | $24 | 4GB | Small teams |
| t4g.large | $48 | 8GB | Medium teams |
| c7g.large | $58 | 4GB | CPU-optimized (template default) |
| t3.medium | $30 | 4GB | x86 if you need Intel compat |

---

## Cleanup

One command removes everything:

```bash
aws cloudformation delete-stack \
  --stack-name openclaw \
  --region us-west-2
```

No orphaned resources. No lingering charges.

---

## Troubleshooting

**Stack creation fails:**
```bash
aws cloudformation describe-stack-events \
  --stack-name openclaw \
  --region us-west-2 \
  --query 'StackEvents[?ResourceStatus==`CREATE_FAILED`].[LogicalResourceId,ResourceStatusReason]' \
  --output table
```

**SSM can't connect:**
- Wait 2-3 minutes after stack completes — SSM agent needs to register
- Verify the instance is running: `aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].State.Name'`

**Token not found:**
- The SSM parameter name includes your stack name: `/openclaw/{stack-name}/gateway-token`
- If you named your stack something other than `openclaw`, adjust accordingly

**Bedrock returns nothing:**
- Verify Haiku is enabled in your region's Bedrock model access page
- Check the model ID matches exactly: `global.anthropic.claude-haiku-4-5-20251001-v1:0`

---

## Links

- [Source template](https://github.com/aws-samples/sample-OpenClaw-on-AWS-with-Bedrock)
- [OpenClaw docs](https://docs.openclaw.ai)
- [SSM Session Manager plugin install](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html)
- [Bedrock model access](https://console.aws.amazon.com/bedrock/home#/modelaccess)

---

**Made by [CloudYeti](https://cloudyeti.io)** — AI workshops for engineering teams.
