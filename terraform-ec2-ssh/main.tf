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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWzIGitZjNaLzIP67NHT4RnBBJS5vvuqaQ5rnbw+sj/wk9fbRTiOyR0U4tMgJ8qRDZPk0RALEKGPLsVjbSRxX9nQkV7l5wE0OSI0DKHlCtSGh00ay5rV52lr0uiDfJH3qzk4T0WeqFuu++xQhcNn1avBmbqLVFWiFNdG+DvYnImhG7t8wzGvEANNaxpeIilyxGelAQhGj7BuXZexAT0lZ3Krn4icok9rtNj3aKkRuAfksvxcanixQ0+q+WryBh722kYzYBBTsI+dpLkB0C/5lpmGnscLhLcK18Nu/4+1l7KJZfpi3+N/VxVbN10qzmpkXag+GNEOm8Groy5VAYiCIh27isiZdg51rnN0DNC3Mpic/iqqY7z1ehDnkzEj4ychuZQY6lUxZZowFuYe29PN3QXeqysA4vEcLhATEpulCxc3EqNveYrUdQXIx7HSWJntF56vlEIy5XPSDHV2qP20vqfIHA99Xe5J6VHQ29WpTEoSWZ1+yh1dUVHBHsVMMM9rAWelsUuCO8O7tvesaAnbnrEhLHVjXND918Z5l2u5vqIHWyW5Nf+yZeOHIK2NZLzgyZwqZatRIKD0dL/76Ib4avBBydVQJ2fbTF6n/sWSPYOErg7sJYvZVMcK4ckWAJ04swSb9zNf7rnOOARvQ4aeSpFAfjm3I4TUYa6vnkwXxJjQ== andrew.z@onmail.com"
}
