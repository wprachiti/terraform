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


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mywebapp_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapp" {
  bucket = aws_s3_bucket.mywebapp_bucket.id
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action    = "s3:GetObject",
          Resource  = "${aws_s3_bucket.mywebapp_bucket.arn}/*"
        }
      ]
    }
  )
}

resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.mywebapp_bucket.id

  index_document {
    suffix = "index.html"
  }
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