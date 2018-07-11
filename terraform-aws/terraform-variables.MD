## This file contains some details on how terraform variables work.


If you've used aws cloudformation before , the variales area a lot like parameters on AWS Cloudformation.  To get started quick, hard coding is okay. But eventually you will want to move to using variables, because things become sharable, modular and reusable.
Anyways, back to variables. Let's say that you want to create a terraform template that will deploy a VPC with few EC2 instances over and over again.\

To log in to the EC2 instance you need to have a key file described. So you could do something like this on the configuration file

```HCL



resource "aws_instance" "web-server" {
  ami = "ami-abcdef"
  instance_type = "t2.micro"
  key_name = "my-key"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

  tags {
    Name = "terraform-web-server"
  }
}
```

The problem here is that when you share the file with others, they have to manually edit the key everytime. And sometimes, people forget to do that. Then they don't know what's wrong with the template. 

This problem can be solved by using variables in terraform.

Check the block of code below and notice the difference when trying to achieve the same thing as above this time by using variables.

```HCL
variable "ec2-key" {}


resource "aws_instance" "web-server" {
  ami = "ami-abc123"
  instance_type = "t2.micro"
  key_name = "${var.ec2-key}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

  tags {
    Name = "terraform-web-server"
  }
}

```

Notice the difference? We refered to the variable to get the key-name instead of hardcoding it. Now when we want to run the script, we will be asked for a value for the key-name.

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


  
  
Reference:https://www.terraform.io/intro/getting-started/variables.html
