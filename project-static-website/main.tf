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

resource "aws_s3_bucket" "mywebapp_bucket" {
    bucket = "mywebapp-bucket-${random_id.my_random_id.hex}"
  
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.mywebapp_bucket.id
  key    = "index.html"
  source = "./index.html"
  
}

resource "aws_s3_object" "styles_css" {
  bucket = aws_s3_bucket.mywebapp_bucket.id
  key    = "styles.css"
  source = "./styles.css"
  
}

output "name" {
  value = random_id.my_random_id.hex
}