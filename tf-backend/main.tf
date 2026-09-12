terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "prach-terraform-s3-bucket-2b251a20ed4713eb"
    key = "remote_backend/backend.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myserver" {
  ami           = "ami-08188a5a4dfdbd573"
  instance_type = "t3.micro"

  tags = {
    Name = "SampleServer"
  }
}