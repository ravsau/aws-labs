

provider "aws" {
  region = "us-east-1"
}


variable "ec2-key" {}

variable "ami"{
    default="ami-b70554c8"
}

resource "aws_vpc" "july-vpc" {
  cidr_block       = "10.0.0.0/16"


  tags {
    Name = "july-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.july-vpc.id}"

  tags {
    Name = "terraform-IGW"
  }
}



resource "aws_subnet" "private-subnet" {
  vpc_id     = "${aws_vpc.july-vpc.id}"
  cidr_block = "10.0.1.0/24"

  tags {
    Name = "private-subnet-10.0.1.0/24"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = "${aws_vpc.july-vpc.id}"
  cidr_block = "10.0.2.0/24"

  tags {
    Name = "public-subnet-10.0.2.0/24"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id     = "${aws_vpc.july-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }



  tags {
    Name = "private-subnet-10.0.1.0/24"
  }
}



resource "aws_security_group" "allow_ssh" {
  name        = "allow_all_ssh"
  description = "Allow all inbound ssh traffic "

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_all_ssh"
  }
}



resource "aws_instance" "web-server" {
  ami = "${var.ami}"
  instance_type = "t2.micro"
  key_name = "${var.ec2-key}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

  tags {
    Name = "terraform-web-server"
  }
}
