When you first log into the EC2 instances on AWS , you can only ssh using key pairs. 

so the command to log in looks something like this:
```console
ssh -i mykey.pem ec2-user@32.33.34.35 
```

But what if you want to enable password ssh?

We can follow these steps :

1) Create an EC2 instance. If you have one already , skip this step.
2) Become the super user and open the sshd config file
```console
sudo su
vim /etc/ssh/sshd_config
```
3) Change the PasswordAuthentication no config to 
```vi
PasswordAuthentication yes
```

4) Restart the sshd daemon
```console
service sshd restart
```

5) set the password for the ec2 user /or create new user
```
passwd ec2-user
adduser bob
passwd bob
```

6) Exit out and try loggin into the EC2 using the password
```console
ssh ec2-user@32.33.34.35 -p
```

**you should now be logged in without using the .pem file**




