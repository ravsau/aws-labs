resource "aws_instance" "example" {
  ami           = "ami-066663db63b3aa675"
  instance_type = "t2.micro"
  key_name = "terraform-key"
  security_groups = ["${aws_security_group.allow_rdp.name}"]

}
