terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "demo_bucket" {
    bucket = "prach-terraform-s3-bucket"
  
}

resource "aws_s3_object" "object" {
  bucket = "prach-terraform-s3-bucket"
  key    = "files/my_file.txt"
  source = "./my_file.txt"
  
}