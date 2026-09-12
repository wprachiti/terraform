terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "random_id" "my_random_id" {
  byte_length = 8
  
}

resource "aws_s3_bucket" "demo_bucket" {
    bucket = "prach-terraform-s3-bucket-${random_id.my_random_id.hex}"
  
}

resource "aws_s3_object" "object" {
  bucket = "prach-terraform-s3-bucket-${random_id.my_random_id.hex}"
  key    = "files/my_file.txt"
  source = "./my_file.txt"
  
}

# output "name" {
#   value = random_id.my_random_id.b64_url
# }