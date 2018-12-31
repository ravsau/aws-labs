import json
import boto3
import os

sns= boto3.client("sns")
topic= os.environ["TOPIC"]

def lambda_handler(event, context):
   print (event)
   print (event["detail"]['userIdentity']['type'])
   a= event["detail"]['userIdentity']['type']
   username="root"

   if a!="Root":
      username= a= event["detail"]['userIdentity']['userName']
   response= sns.publish(TopicArn=topic, Subject='notification-console-login', Message="Someone with the username of " + username +  " in your account logged into  AWS Management console")
