# AWS LAB on Cloudwatch event pattern and Lambda Integration


# Youtube link: N/A

## Requirements
- IAM Role with SNS and cloudwatch Access 
- SNS Topic with subsriber that reveives the message
- Lambda function with code that sends sms to a topic
- Cloudwatch event rule that will trigger based off event pattern



## Steps
1) Create the IAM Role
2) Create the SNS Topic
3) Create the Lambda function
4) Create the cloudwatch event rule with event pattern
5) Simulate the event with login/ logout




### Create an SNS Topic
![image](https://user-images.githubusercontent.com/22568316/45520223-630b8480-b786-11e8-816e-66442c2a4db9.png)
---

### Confirm SNS email
![image](https://user-images.githubusercontent.com/22568316/45520198-3a838a80-b786-11e8-9c9b-6a9f14b4449c.png)
 ---
![image](https://user-images.githubusercontent.com/22568316/45520259-87676100-b786-11e8-9445-7db53b8d338d.png)


### Create rule
![image](https://user-images.githubusercontent.com/22568316/45520557-e679a580-b787-11e8-98f6-95fb7050b815.png)
---

Logged in - 7:05
Notified- almost immediately

## EMAIL IS SENT 
![image](https://user-images.githubusercontent.com/22568316/45521024-2e99c780-b78a-11e8-8393-2f5ad85ac9e2.png)
---


TODO:
Modify Lambda Function: cloudtrail-cloudwatchevents-s3-acl-change 
  - add logic to parse and check for   : "Permission": "FULL_CONTROL"  . If yes then change the ACL to private.  ![image](https://user-images.githubusercontent.com/22568316/45531356-6ec66d80-b7bd-11e8-9452-6f950a7ca659.png)
