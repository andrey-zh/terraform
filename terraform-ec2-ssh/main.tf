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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6avADZgF1pTh3PcgO9aWU+n269kLlaeGyGamO+acYus/vzPjr2hjZpVeeTe5oMgRP6DlQc6Eye+89ztUvivtPYP2YveDz0jynSOUwHU9JVDAnadaRfCOlF9e8OvOC9NXcP0Q54EUrZ//B/UG2vkJjIWM128WfBpMlnis6ZLr7d7lncZRwayDOs9tQPbZuC6E2qOugO+WY5A3lTSdCCQPfLvw6JnKyf3uD+vhiLAMpfAkDC1djAN7KgXyzSNp7pA5SGl4yD0e5DAHqvXKslAtnc9uRTS7yl8bacH2U7mifx+Pr5bsIdE1P1ilf+BjCGYOtB0i5VBpG0RQOoIlvrhp3mJGUP8EuslCeP9g2kptT0KPrd/b80cziZ5IlrIdDGtRbfMD9daRwDnOBEidLzy9zVCwi3dc4FZHp0H/I9Y+/VfJNyVwwMDHXwYGjNl9EwtFvbP299KaBMup0c4IakxBc7X8/oiwIhrsjojGesTa+f6i++rgDZ2/oDabpcqafIXw+h+psARWF9jAftcpdv++J1L3PJll7YtfsdAtikT50u248bqBh7lNt1fTu7mJq3op464d8YWjLSnkhUIoJ6niMMjv4JLjQ2WVif/6OtVYuNi31V4MO7eyWJlb4rZdhU3TvysvSRrDWWy5BNz0+KAfrrvjOUiWD9etQTZx9brD/jw== andrew.z@onmail.com"
}
