terraform {
  backend "s3" {
    bucket = "cloudyeti-terraform"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
