## Pre-requisite
-  boto3 SDK is installed on your machine
  - https://boto3.amazonaws.com/v1/documentation/api/latest/guide/quickstart.html



## Steps 
1) (OPTIONAL) Create a new S3 Bucket
2) Open a new text file and copy this code and save it as a .py file

```python
import boto3
s3 = boto3.client('s3')

"""
If you don't have CLI and therefore AWS Credentials setup , then un-comment the lines below and remove the line above. Add your AWS credentials.

s3 = boto3.client(
   's3',
   aws_access_key_id='AKIAIO5FODNN7EXAMPLE',
   aws_secret_access_key='ABCDEF+c2L7yXeGvUyrPgYsDnWRRC1AYEXAMPLE'
) 
"""

bucket = raw_input("Enter your Bucket Name: ")
key= raw_input("Enter your desired filename/key for this upload: ")

print (" Generating pre-signed url...")

print(s3.generate_presigned_url('put_object', Params={'Bucket':bucket,'Key':key}, ExpiresIn=3600, HttpMethod='PUT'))
```

3) On your command line/terminal navigate to the directory/folder where you saved the .py file
4) Execute the script and enter your bucket name and desired filename/key
5) You will receive a pre-signed url
6) On your command Line use curl to upload any file to S3 using Pre-signed URL
```
curl --request PUT --upload-file text.txt http://your-pre-signed-url.com
```
7) Check your S3 bucket and your upload should be successful. Congrats!






## References:
 https://boto3.amazonaws.com/v1/documentation/api/latest/guide/s3.html#generating-presigned-posts
 
