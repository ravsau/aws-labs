# AWS LAB: Provision an EC2 quickly

Sometimes, we may need an ec2 for a quick thing or may just want to create an ec2 with some desired setting over and over again. This is one of many ways you can do that. Our goal is to be quick in creating an EC2 that works. Feel free to edit and even submit pull request with improved code.


## Steps

1) I'm assuming that your default Security Group had ssh access. If not, you may have to add a SG with SSH after you provision the ec2. Or just make some changes in the code to make it work.

2) Clone this repo. 

3) Make this script executable
```
chmod +x run-ec2
```

4) Add the folder with this script to your PATH. You can do this by modifying the ~/.bash_profile file( permanent fix)  or entering the command below in the terminal. This is a temporary way to add the executable to the PATH. 
```
export PATH= $PATH:/path-to-this-script
``` 

5) Open the file and replace the key-name on line 4 . Make some more changes if you want.

6) Save the changes 

7) type this command on your terminal
```
run-ec2
```

You should get an output like this:
```console
Use this to login: ssh -i mykey.pem ec2-user@11.11.22.33
```

Thanks for doing this Lab! checkout my github and [youtube channel](www.youtube.com/c/sauravsharmacloud) for more.
