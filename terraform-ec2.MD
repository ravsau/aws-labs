In this mini lab/lesson we are going to provision an EC2 using Hashicorps's terraform.

## What is Terraform? 

Terraform is a tool made by Hashicorp for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers ( aws, azure, Google cloud) as well as custom in-house solutions.

You can compare **Terraform** to **Cloudformation**
. They are simililar but at the same time have differences.




### Steps to provision

1) Download the terraform binary file 
https://www.terraform.io/downloads.html
2) Extract the zip file
3) You will see the terraform binary executable  file 
4) make sure that the terraform binary is available on the PATH. 

For Mac/Linux. On the shell/terminal,  go to the folder where terraform binary is extracted 
```console
echo $"export PATH=\$PATH:$(pwd)" >> ~/.bash_profile
source ~/.bash_profile
```

For Windows users : follow this to add Terraform to PATH https://stackoverflow.com/questions/1618280/where-can-i-set-path-to-make-exe-on-windows



5) Inside a folder of your choosing( documents, desktop , etc) make a directory and name it something like
```console
mkdir terraform-july && cd terraform-july
```

6) Paste this code to a file called ec2.tf( can be anything.tf)

#### minimal viable configuration

```HCL
provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
```

#### Note:

If you've setup the AWS CLI and have credentials stored , you may skip the credential portion.
This is what Hashicorp says "If you simply leave out AWS credentials, Terraform will automatically search for saved API credentials (for example, in ~/.aws/credentials) or IAM instance profile credentials. This option is much cleaner for situations where tf files are checked into source control"

7) initialize the working dir for terraform
```console 
terraform init
```

8) Provision the ec2 with this command
```console
terraform apply
```

9) Check your EC2 console to make sure an instance got provisioned

10) From your terminal/command prompt/ shell , destory the resources
```console
terraform destroy
```


That's it! you installed Terraform and used it to proision an EC2 instance. 
