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
