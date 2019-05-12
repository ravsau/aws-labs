## This file contains some details on how terraform variables work.


If you've used AWS cloudformation before , the variables are a lot like parameters in AWS Cloudformation.  

To get started quickly, hard coding values on your configuration file is okay. But eventually you will want to move to using variables, because variables make things sharable, modular and reusable.

Let's say that you want to create a terraform template that will deploy a VPC with few EC2 instances over and over again.\

To log in to the EC2 instance you need to have a key file described. So you could do something like this on the configuration file

```HCL

resource "aws_instance" "web-server" {
  ami = "ami-abcdef"
  instance_type = "t2.micro"
  key_name = "my-key"
  security_groups = ["${aws_security_group.allow_ssh.name}"]


  tags {
    Name = "terraform-web-server"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh traffic"


  ingress {

    from_port   = 22 #
    to_port     = 22
    protocol =   "tcp"

    cidr_blocks =  ["0.0.0.0/0"]
  }
}
```

The problem here is that when you share the file with others, they have to manually edit the key every time.

This problem can be solved by using variables in terraform.

Check the block of code below and notice the difference when trying to achieve the same thing as above this time by using variables.

```HCL
variable "ec2-key" {} # this is how you declare a variable.

variable "ami" {default='ami-0080e4c5bc078760e'} # You can have default values for variables


resource "aws_instance" "web-server" {
  ami = "${var.ami}"
  instance_type = "t2.micro"
  key_name = "${var.ec2-key}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

  tags {
    Name = "terraform-web-server"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh traffic"


  ingress {

    from_port   = 22 #
    to_port     = 22
    protocol =   "tcp"

    cidr_blocks =  ["0.0.0.0/0"]
  }
}


```

Notice the difference? We referred to the variable to get the key-name instead of hardcoding it. Now when we run `terraform apply`, we will be asked for a value for the key-name.

This way we can change the value of the variable at run time giving us ability to choose different SSH key pairs as needed without modifying the configuration file.


--------
There are multiple ways to pass in variables when running the terraform apply command.
In the order of preference
1) as a command line flag
```console
$ terraform apply -var 'key-name=my-key'

```

2) A seperate variable file which you reference like this while running the script.
```console
terraform apply  -var-file="vars.tfvars"
```
> For all files which match `terraform.tfvars` or `*.auto.tfvars` present in the current directory, Terraform  automatically loads them to populate variables. If the file is named something else, you can use the -var-file flag directly to specify a file. These files are the same syntax as Terraform configuration files.


3) Environment variables:
Terraform will read environment variables in the form of TF_VAR_name to find the value for a variable. For example, the TF_VAR_access_key variable can be set to set the access_key variable.

4) If none of the first 3 steps are used to set variables, you are asked for variables when you run terraform apply.
```console
$ terraform apply
var.ec2-key
  Enter a value:
```



5) Default variable values. You could set a default value when declaring the variable.
```HCL
variable "ec2-key" { default = "my-key"}

```

## Homework: It's your turn now
Convert Instance type and EC2 instance tag into variables too.




For more Reference:https://www.terraform.io/intro/getting-started/variables.html
