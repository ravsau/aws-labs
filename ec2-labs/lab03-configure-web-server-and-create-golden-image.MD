## Lab 3 : Install the Apache web server in EC2 instance and create a golden image from it

- Launch an Amazon Linux EC2 Instance and SSH into it like we did in Lab 1 


- Install the Apache web server

```console
sudo yum -y install httpd
```
- Start the HTTPD service.

```console
sudo service httpd start  
```

- Enable HTTPD server on startup
```console
sudo chkconfig httpd on

```
- Go to the EC2 Dashboard and Select the instance. 
- Under Instance description and Click on the Security Group's name. 
- Add edit rules and add an inbound rule with port 80 and source IP of  0.0.0.0/0 

- Test the Web Server is running by pasting the the Public IP adress of the Instance in a Web browser. The Public IP is found under Instance Description tab .

- You should see the Apache Web Server Welcome Web Page

- Become the root user
```console
sudo su - 
```
- Create a simple custom index.html page and put it on /var/www/html . This directory is the default directory where Apache webserver will look for index.html file. 
```console
echo "Hello. This page is hosted on my AWS EC2 Linux Instance.">/var/www/html/index.html
```
- Change the permission of the html folder to give public access to the index.html file
```console
chmod -R 755 /var/www/html
```

- Now browse the IP of the instance in a webserver again. You should see your Message 
```
Hello. This page is hosted on my AWS EC2 Linux Instance.
```


------
- Select your instance, and then choose **Actions**, **Image**, **Create Image**\.
- In the **Create Image** dialog box, specify the following information, and then choose **Create Image**\.
   + **Image name** – A unique name for the image\.
   + **Image description** – An optional description of the Image
   + **No reboot** – This option is not selected by default\. Amazon EC2 shuts down the instance, takes snapshots of any attached volumes, creates and registers the AMI, and then reboots the instance\. Select **No reboot** to avoid having your instance shut down\.

-  To view the status of your AMI while it is being created, in the navigation pane, choose **AMIs**\. Initially, the status is `pending` but should change to `available` after a few minutes\.

  
-  Launch an instance from your new AMI. Follow Lab 1 and in the AMI page when choosing the AMI select My AMI and select the AMI you created. 
- Browse the IP address of the new instance. You should see the same message as before. 

We just created a golden image that we can now use to launch more instances. A golden image is , in simple terms an image that you have customized to with liking with data/configuration of your choice. It's saved as a personal AMI from which you can launch instances.
