## Lab 8 : Install Cloudwatch unified agent on EC2 instance. Gather Custom Metrics using Amazon Linux AMI

1)  First of all create required IAM roles for the EC2 instances to be able to send metrics to cloudwatch
  - In the list of policies while creating IAM Role for EC2 Instance, select the check box next to **CloudWatchAgentServerPolicy**. Use the search box to find the policy, if necessary.

2) Launch an EC2 instance with port 80 and 22 open in the security group.

3) SSH into the instance

4) Find the cloudwatch agent download link here:
https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-on-first-instance.html

5) Download the Cloudwatch Unified Agent. Find the right agent link for your OS by visiiting the above link
```console
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
```


6) Install the Cloudwatch Agent
```console
sudo rpm -U ./amazon-cloudwatch-agent.rpm
```

7) Configure the Cloudwatch agent with the help of a setup wizard:

```console
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
```

Choose all the default option except don't install statd and collectd. Selecy **YES** when asked to collect Memory Utilization metric.  Select **NO** when asked if you want to monitor log files.

8) Start the agent


```console
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
```

9) You should be set! We'll explore the collected metrics now.

## Part 2 : View the collected cloudwatch custom metrics



In the first part of this lab we configured the cloudwatch Unified agent. Now let's look at the metrics collected by the agent.

Remember: RAM/Memory metrics are not collected by Cloudwatch by default. Cloudwatch agent enables us to collect those metrics not collected by default.


In the config wizard we selected to collect Metrics like Ram etc.


## Steps
1. Navigate to Cloudwatch Management Console
![image](https://user-images.githubusercontent.com/22568316/51443494-8e175f00-1cb7-11e9-94a5-d738cdaa5cad.png)

2. On the left navigation pane select Metrics and you should see a window like this:
![image](https://user-images.githubusercontent.com/22568316/51443506-adae8780-1cb7-11e9-89b3-aecb59a641fc.png)

3. Click on the CWAgent. This is the metrics sent by the Unified cloudwatch agent
![image](https://user-images.githubusercontent.com/22568316/51443506-adae8780-1cb7-11e9-89b3-aecb59a641fc.png)

4). Click on the ImageId, InstanceId, InstanceType Box
![image](https://user-images.githubusercontent.com/22568316/51443521-ea7a7e80-1cb7-11e9-86df-0ce2b046c8e8.png)


5) Select/Check  the Mem Used metric and you should see something like this
![image](https://user-images.githubusercontent.com/22568316/51443528-0c740100-1cb8-11e9-9b11-b80a9df0c049.png)


6) Congratulations! you just collected and graphed EC2 Custom metrics using the Cloudwatch Unified Agent









## Reference
https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/QuickStartEC2Instance.html
