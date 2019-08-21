

## Lab 05 : AWS EC2 Command Line Interface commands 

**Use Amazon Linux  AMI* to launch an EC2 instance with port 22 open
**Make a note of AMI ID in your region**
Make

1) Create an EC2 instance with the CLI:
```console
aws ec2 run-instances --image-id ami-8c1be5f6 --instance-type t2.micro 
```

2) Let's launch another instance with Windows AMI

```console
aws ec2 run-instances --image-id ami-07a29e78aeb420471 --instance-type t2.micro 
```


3) List all the instance and their details. 
```console
aws ec2 describe-instances
```

4) Describe and query specific things( List specific attributes). Let's query IP of all the instances.

```console
 aws ec2 describe-instances --query 'Reservations[].Instances[].PublicIpAddress'


```

5) Describe and filter to show only windows Instance

```console
aws ec2 describe-instances --query 'Reservations[].Instances[].PublicIpAddress' --filters "Name=platform,Values=windows"

```

6) Stop EC2


```console
aws ec2 stop-instances --instance-ids i-0b20d7680fa0e6ba0
```


7) Terminate EC2

```console
aws ec2 terminate-instances --instance-ids i-0b20d7680fa0e6ba0
```


Congratulations! You now know the basic AWS EC2 CLI Commands. 



## Reference
https://docs.aws.amazon.com/cli/latest/userguide/cli-services-ec2.html
