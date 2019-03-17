## Note
Terraform v0.12 is about to be released soon. What we mention in this lesson may change with the new release as terraorm docs mention this. 
>Terraform v0.12 will be a major release focused on configuration language improvements and thus will include some changes that you'll need to consider when upgrading. 

## Terraform working direcotory and the root module: how to break up configuration files ( templates) 
A module is a container for multiple resources that are used together.

Every Terraform configuration has at least one module, known as its root module, which consists of the resources defined in the .tf files in the main working directory.


In the previous lessons, we had only one .tf file in the working directory when we called the terraform apply command. 


## Instead of having one .tf file that contains everything, we can break the resource blocks into multiple .tf files. When you call the terrform apply command, terraform applies code in all the .tf files in the working direcotory.

For example, instead of having this in ec2.tf file where provider block is included with the ec2 resource block:
```
provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-066663db63b3aa675"
  instance_type = "t2.micro"
  key_name = "terraform-key"
  security_groups = ["${aws_security_group.allow_rdp.name}"]

}

resource "aws_security_group" "allow_rdp" {
  name        = "allow_rdp"
  description = "Allow rdp traffic"


  ingress {

    from_port   = 3389 #  By default, the windows server listens on TCP port 3389 for RDP
    to_port     = 3389
    protocol =   "tcp"

    cidr_blocks =  ["0.0.0.0/0"]
  }
}

```


We can break these blocks into multiple files. 

First, let's put the provider into a single **provider.tf** file 
```
provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region     = "us-east-1"
}

```

Then let's put ec2 resource in a **ec2.tf** file
```
resource "aws_instance" "example" {
  ami           = "ami-066663db63b3aa675"
  instance_type = "t2.micro"
  key_name = "terraform-key"
  security_groups = ["${aws_security_group.allow_rdp.name}"]

}
```

And finally, the security group in a seperate file **sg.tf**, 
```
resource "aws_security_group" "allow_rdp" {
  name        = "allow_rdp"
  description = "Allow rdp traffic"


  ingress {

    from_port   = 3389 #  By default, the windows server listens on TCP port 3389 for RDP
    to_port     = 3389
    protocol =   "tcp"

    cidr_blocks =  ["0.0.0.0/0"]
  }
}
```

When you call this command in the working directory with these 3 .tf files
```
terraform apply
```

Terraform combines code in all 3 .tf files and applies the changes. 

This let's you break your infrastructure code into multiple files which provides multiple benefits. 

  - you can put a certain file like provider.tf in gitignore so that you don't commit the provider settings to version control like github
  - Multiple files are easier to work with. 
  - Compare this to cloudformation, where you have to use concept of nested stack , terraforms' approach looks much cleaner. 
  


That's all for this lesson. See you in the next one. 



## Reference
https://www.terraform.io/docs/configuration-0-11/modules.html
