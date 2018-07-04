In the last lesson/lab we setup password authentication on our EC2 Instance. [Click here](https://github.com/ravsau/aws-labs/blob/master/enable-password-ssh.MD) to go to that lesson.
This process workd not only for EC2 insance but for any Linux remote instance. 

In this lab, we will setup password-less and keyless ssh so we can type something like 
```console 
ssh user@11.22.33.44
``` 
from our local machine and we will be logged into the remote linux machine without providing password or keys.


**if you're working on macOS or linux locally you can use your default shell/terminal. If you're on windows I recommend you download git bash. \
https://git-scm.com/downloads \
Once you download it, open it and all of us should be on the same page.**

## We will look into  2 ways to do this :

## Way 1

## Steps ( You need to have password authentication enabled on EC2 instances to follow these steps properly. [Click here](https://github.com/ravsau/aws-labs/blob/master/enable-password-ssh.MD) to view the steps if you haven't done that )

1) Navigate to the .ssh directory and list it's content . 
```console
cd ~/.ssh
```

**this is just to note the no of contents. We will list the directory again later.**

2) ssh into the ec2 instance normally or with a password. Replace the example IP with your Instance IP
```console
ssh ec2-user@11.22.33.44 
```

3) Navigate to the ssh directory of the EC2 instance and list the direcory to see the contents
```console
cd ~/.ssh
ls 

```

4) **Optional** Remove the contents of that direcotry. A new file will be added later.
```console
rm *
ls

```
the diretory should be empty now.

5) Exit out of the remote computer 
```console
exit
```


```
6) On your local machine Use ssh-keygen utility to generate a key pair 
```console
ssh-keygen
```

7) press enter when your're asked for name, password etc. This will select the default options.

8) Navigate to the .ssh folder in local machine to view the keys generated
```console
cd ~/.ssh
```
You can see that some files have been added. These are the private and public keys(key-pair) that we generated with ssh-keygen earlier

9) Copy the public key to the remote machine. Enter the password when prompted
```console
ssh-copy-id ec2-user@32.33.34.34
```

10) Now ssh-into the remote EC2 without password or keys
```console
ssh ec2-user@32.33.34.34
```

**congratulations!! you just setup password-less key-less ssh**


11) Navigate to the .ssh folder inside EC2 and list its contents
```console
cd ~/.ssh
ls
```
12) you should see an authorized_keys file

13) View the contents of that file
```console
cat authorized_keys
```

14) the content of the public key we generated locally  is added to this file

---------------------

## Way 2

1) On your local machine open/create the file 
```console
vim ~/.ssh/config
```

2) Paste this config and edit the IP to the IP of your EC2 instance IP and change the location and name of your .pem file
```vim
Host ec2
     HostName 18.206.86.235 
     User ec2-user
     IdentityFile ~/cloudform-key.pem
```

3) ssh into the instance using the Hostname

```
ssh ec2
```
You should be logged in to your ec2 instance.

Easy right?

**That's it for this lesson. See you in the next one!**
