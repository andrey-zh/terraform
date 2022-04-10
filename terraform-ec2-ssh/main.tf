provider "aws" {
   region     = "us-east-1"
}

resource "aws_instance" "ec2_example" {

    ami = "ami-0d82da962c81d0a85"  
    instance_type = "t2.micro" 
    key_name= "ssh_key"
    vpc_security_group_ids = [aws_security_group.main.id]

    tags = merge (
      {
          Name = var.instance_name,
      },
    )

  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo hello world! >> hello.txt",
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/Users/andrew/terraform/terraform-ec2-ssh/ssh-key")
      timeout     = "30m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name   = "ssh_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJcXAMyYb0LdB9fvmeB9jeBJm+gyAtZDgkjBvigdXmiyY6HFP+sRf6PqCKYrSUmxyC1QYtGk1o1+sjb871Ndg75Vq5CeznKDZ2hDzvrnB8wNrqQlBAx2/tVxuTecozzqw0naqWFERy9HcPvlEc1eTCcYgl0H1x8159VeOQVvgC5Ay+ftd3cPnn7AKvhnvasjZFPWkvJmlwLmxarm78YEjxgCkZz/9Nn3Vv7PMWhJFxxl2x596eCMe8+YwCsLmMQM9cUluv7vE4T5aDdg0pbxBS14Lvq/2ukqsrfRMJmKYyy6WkCOeVw3rYanyBjmlKF1gYhjKfEK4hKxAN8jfR/rMtM/L7hW7tbLZT6QIWpluzOY3vsD4Qy48hNbp9oJtmrndMHc0jgE98AjvP/rGD3nrkwAmMHz92ol0vT8gzdfs68uSMToQeqXZWhLvrvEacMD8vRU31NYCNOW1EGE3SRZYvgVBN8X4Lq979SP4HZRqFvMcJ0SLqvu5vfM6x7p/j3bsHKS5l3bZpK57CnpEW3lh3qzxh1j/OuFl44JvNtMBJeKJ/G5I6Dfdma0jH8kyKMC9FNe96RY5vhj8LQ8uIJlwMV2vqlVkj5bDuO88yn3vLEGAU4ZomBkG7axRn0OnHOe9tV1Fe8mKpUldEh4nC4yEPub6CI9qzuVD18FpodLJoPw== andrew.z@onmail.com"
}
