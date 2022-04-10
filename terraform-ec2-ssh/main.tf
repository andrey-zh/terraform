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
      private_key = file("/Users/andrew/terraform/terraform-ssh/ssh-key")
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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCryCcl0hNqj3Wor4Y2Q1J+X4RpUUM62aAs156xhR2J1k4cxxEDfNDOigfv/HiIrcWuxy0kt/kzLBUiZyLPBmSkcRw+GKe96lKhhGB2XlDx3jP/fC2QXJYtgm/GKnUB+nBzPrLOSc13sN85BriC3tSSVLx1LeCiHSgX4hjoG5c4R+79poZR99E863tIMn4N5SoCCq1FM3isKyKFmtfDYgvdziBlNNzhxkigfzbYxqwoMSKEmfD7iBlkbBE3H9uT+C38hQZsqFPVluNv8aUfItTzizFYQFJmolhf0qOh8vUL8evli2y/WbXMWTdy6JLctg1Z4k/qUVVm+d3MUieUA2umnPgZpliuMsdffPVSoXcz0fRkuwljlALNXq6n9H9A17vSMaVwFLAKknQrp54oDZzHDqbw4IQxjFUrcf7B+iylCjDtCjyba37knBtdf3qBMVxQb1ooodZGuUIO5xIRrpMjgjOO88T7P+h6N8GeZQ+zTT0CdxQ7uyakTlae0ApbOpmpR8DI7Z2akM9m33r18UsfZKk/i6uPLBiq5BeDI4ektvRTdv02os7C5tHNQMaShYsQPZ6mXgwxAsHezEpem+EBA1IeNRQzmCRvAJrH2VUQFebWb8PyN71z9z98BFs5mVP0dN4+8FBO49Ik0UvL1caCZ+xnUxZ7DftjYQNYE4vL3w== andrew.z@onmail.com"
}
