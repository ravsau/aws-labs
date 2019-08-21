variable "ec2-key" {} # this is how you declare a variable.

variable "ami" {
  default = "ami-0080e4c5bc078760e"
} # You can have default values for variables. Variables with default value won't be prompted when you run terraform init.

resource "aws_instance" "web-server" {
  ami                    = "${var.ami}"
  instance_type          = "t2.micro"
  key_name               = "${var.ec2-key}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

  tags {
    Name = "terraform-web-server"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh traffic"

  ingress {
    from_port = 22    #
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
}
