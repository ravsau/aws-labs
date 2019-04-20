## Lab 9: Send Apache web server logs to cloudwatch

In the last 2 labs ( 8 and 9) we first installed cloudwatch unified agent and set up custom metrics and viewed custom metrics on the AWS Management console.

In this lab we will send our apache httpd logs to cloudwatch and check our logs from the AWS Managemenet Console. 

## Steps 

1) First let's install and start a web server to generate some web traffic logs. This commmad works for RHEL and Amazon Linux.
```console
sudo yum install httpd -y
sudo service httpd start

```
2) Copy the public IP of the instance you're on and paste that in a web browser and refresh a few times. 

3) That should generate some logs. You can verify by taking look inside the log file
```console
sudo cat /var/log/httpd/access_log
```

Now we're ready to setup cloudwatch logs. 

3) Reconfigure the cloudwatch agent with the wizard
```console
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
```
Check my choices here. Most of the choices are default except for some. If you don't see the number in the image, that means I chose the default option. Sometimes I explicitly select the default option. 
![image](https://user-images.githubusercontent.com/22568316/51447423-f97b2400-1ceb-11e9-9f2e-b1b7d1f7cffb.png)
![image](https://user-images.githubusercontent.com/22568316/51447468-7d351080-1cec-11e9-8aa8-79b3ce297a00.png)
![image](https://user-images.githubusercontent.com/22568316/51447477-93db6780-1cec-11e9-8264-148d89b54450.png)
![image](https://user-images.githubusercontent.com/22568316/51447481-a655a100-1cec-11e9-8063-988821831d5d.png)
![image](https://user-images.githubusercontent.com/22568316/51447488-b5d4ea00-1cec-11e9-9ea7-ef46be24751e.png)



4) We're done setting up. 
5) Let's start the cloudwatch agent 
```
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
```


wait a few minutes and the logs should be visible in the cloudwatch Management console.Search for **access_logs** in the Logs page on the AWS Management console.

![image](https://user-images.githubusercontent.com/22568316/51448163-8f19b200-1cf2-11e9-9015-93bbede299e4.png)

Click on the instance-id 
![image](https://user-images.githubusercontent.com/22568316/51448197-c4be9b00-1cf2-11e9-9a03-979c338d25f6.png)

You should see logs from your web server now. 
![image](https://user-images.githubusercontent.com/22568316/51448221-f9caed80-1cf2-11e9-8412-630bb2b89f75.png)


Congratulations!! Now you can collect any kind of logs from your Linux machines. 

