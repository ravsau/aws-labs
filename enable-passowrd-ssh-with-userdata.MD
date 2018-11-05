## Steps to enable password authentication and set password for first login on EC2
Paste this script to your EC2 userdata during launch to enable password ssh for your first login. Change user and pass by changing lines under TODO in the below script.

```
#!/bin/bash
sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
systemctl restart sshd
service sshd restart

#TODO: replace bob with your desired username
useradd bob
# TODO: replace password123 with desired password and change bob to your username chosen in useradd 
echo "password123" | passwd --stdin bob
```

If you make no changes to the script , you can login to EC2 after a few minutes using this command. Passoword is password123 . Replace the IP with your EC2 IP
```
ssh bob@11.22.23.24
```
## Assumptions
- Amazon Linux AMI is used , may not work for all linux distros


