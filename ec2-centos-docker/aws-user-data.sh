#!/bin/bash
# Install httpd and set it to run at startup
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>AWS VM deployed using Terraform</h1>" | sudo tee /var/www/html/index.html

# Install Docker
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chkconfig docker on
sudo service docker restart

