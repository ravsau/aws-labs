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

```

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





