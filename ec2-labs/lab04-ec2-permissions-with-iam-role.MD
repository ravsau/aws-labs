# Give EC2 Instance permissions with IAM Role


## Steps
- Go to IAM Dashboard
- Click on User in the left navigation pane
- Add a user and give him programmatic access
![image](https://user-images.githubusercontent.com/22568316/52908358-814c4380-3242-11e9-8283-bc449a588e60.png)
- Click Next and Select the Attach Existing policy directly 
- Search and add **AmazonS3FullAccess**  Use the search box to search for those policies and click the checkbox
![image](https://user-images.githubusercontent.com/22568316/52908368-d25c3780-3242-11e9-86a0-d0c0f590e798.png)

- Click Next Tags and review and create a user. 
![image](https://user-images.githubusercontent.com/22568316/52908385-1fd8a480-3243-11e9-9873-fa0e903bc82d.png)

- Click show and save the access key and secret key somewhere. Or download the CSV file if you want as well. 
![image](https://user-images.githubusercontent.com/22568316/52908451-1ac82500-3244-11e9-9562-52911735583f.png)



- Launch an Amazon Linux EC2 Instance
- SSH into it 
- Let's say you want to work with Amazon S3 from this isntance. Make some buckets and list some buckets. You can use the AWS Command Line interface. Amazon Linux AMI has this installed already. 
- Configure the AWS CLI
```console
aws configure
```
- Enter the access key and secret access keys you generated earlier 

- Enter the name of your region
- Create a S3 bucket from AWS CLI with a random name. If you have proper permissions you will be able to both create and list s3 buckets.
```console
aws s3 mb s3://cloudyeti-test1212342323@mnsdsdcd
```

- List your S3 buckets. 
```
aws s3 ls
```

- You just used Access keys to connect to S3 from EC2. 

- View the credential file. Hardcoded credentials are insecure from a security perspective. 
```
cat ~/.aws/credentials
```
- Delete the file . This will remove the credentials
```
rm ~/.aws/credentials
```

- Try to list the buckets now. You shouldn't be able to because we cleared the access keys. 
```console
aws s3 ls --region us-east-1
```

## PART 2 : Permissions with IAM Roles
- Go to IAM Dashboard and click on Roles 
![image](https://user-images.githubusercontent.com/22568316/52908460-3fbc9800-3244-11e9-933c-0e686380cb5c.png)

- Click Create Role and Select EC2 to be the service using this role
![image](https://user-images.githubusercontent.com/22568316/52908469-5e229380-3244-11e9-8699-2be4c3df60c8.png)

- Click next Permissions and select **AmazonS3FullAccess** policy and attach to this role. Also select **AmazonEC2FullAccess** policy for this role. We will reuse this role in the next lab.
- Click Next Until you see the screen to enter the Role Name.Enter the name and description for the role.  Verify you have S3 and EC2 access policies attached and create the Role. 
![image](https://user-images.githubusercontent.com/22568316/52908497-046e9900-3245-11e9-89d5-93e383ec74d0.png)

- Go to EC2 Instance Page. Select the EC2 instance , Click Actions and Attach IAM Role. Attach the role we created in the previous step. 
![image](https://user-images.githubusercontent.com/22568316/52908517-76df7900-3245-11e9-91f1-ac59869d00f8.png)

- Now go back to the EC2 instance. 
- Enter command to list s3 buckets. You should be able to 
```console
aws s3 ls --region us-east-1
```
- (OPTIONAL) Remove the Role we added a few steps back and try the S3 list command again. It shouldn't work.

Now you see how to give access to S3 and other AWS services using access keys and Role. And you also know Roles are safer because it uses temporary Credentials. 

- Let's keep the same instance for the Next Lab





## How Roles work
Roles use temporary credentials that rotate every 30 minutes or so and are a lot safer than hardcoding keys. 

- Type this command inside your EC2 to view temporary credentials for the role attached to EC2
```console
curl 169.254.169.254/latest/meta-data/iam/security-credentials/{your-role-name}
```
```
