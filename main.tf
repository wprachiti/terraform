provider "aws" {
  region = "ap-south-1"
}

module "ec2_instance" {
  source = "./module/ec2"
  ami_value = "ami-0ac7b260cf76d8865"
  subnet_id_value = "subnet-06d446dc2f0878dd5"
  instance_type_value = "t3.micro"
}