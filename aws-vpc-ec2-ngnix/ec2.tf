
# EC2 instance For Nginx setup
resource "aws_instance" "nginxserver" {
  ami                         = "ami-08188a5a4dfdbd573"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.nginx-sg.id]
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    user        = "ec2-user"  # Replace with the appropriate username for your EC2 instance
    # private_key = file("~/.ssh/id_rsa")  # Replace with the path to your private key
    host        = self.public_ip
  }

  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "app.py"  # Replace with the path to your local file
    destination = "/home/ec2-user/app.py"  # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo yum update -y",  # Update package lists (for ec2-user)
      "sudo yum install -y python3-pip",  # Example package installation
      "cd /home/ec2-user",
      "sudo pip3 install flask",
      "sudo python3 app.py",
    ]
  }
}