## Lab01 Configure and Launch a simple Linux EC2 instance

- Login to AWS console 
- From the top Navigation Bar/menu Click Services 
- Select ec2 service
- Click on Launch Instance
- Choose Amazon Linux AMI
- Choose EC2 Instance Type of t2.micro
- Configure Instance Details
  - There are many parameters  we can configure  but for this lab, we will leave them default. 
- Click "Next:Add Storage , we leave it default
- Click "Next: Add Tags" and Tag Instance
- Configure Security Group, either create a new security group or select an existing one
- Click Review and Launch Instance
- Create a Key Pair, download it  , check the I Acknowledge box and Launch Instance.

Your instance will now launch. 

- Click on View Instance or go back to EC2 dashboard and select the Instance. 
- Click Connect
- Copy the connection string.


If your're on Windows, 
- Download the ssh client for windows https://git-scm.com/downloads 
- Then you can open the git bash terminal to use ssh tool for logging in to your EC2


If you're on Linux/Mac ssh client is already there

- Navigate to the folder with the key pair. Most of the time it's on the downloads folder. 
- If on Linux , use this command to secure your key pair
```console
chmod 400 your-key-name.pem
```
- Paste the connection string in the command line and type yes when prompted. 


You should now be logged into the EC2 linux instance!

