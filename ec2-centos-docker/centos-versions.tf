##############################################
# Get latest CentOS Linux AMI with Terraform #
##############################################

# CentOS 9
data "aws_ami" "centos-9" {
owners      = ["125523088429"]
most_recent = true

  filter {
      name   = "name"
      values = ["CentOS Stream 9*"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }
}

# CentOS 8
data "aws_ami" "centos-8" {
owners      = ["125523088429"]
most_recent = true

  filter {
      name   = "name"
      values = ["CentOS Stream 8*"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }
}

# CentOS 7
data "aws_ami" "centos-7" {
owners      = ["679593333241"]
most_recent = true

  filter {
      name   = "name"
      values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }
}

# CentOS 6
data "aws_ami" "centos-6" {
owners      = ["679593333241"]
most_recent = true

  filter {
      name   = "name"
      values = ["CentOS Linux 6 x86_64 HVM EBS *"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }
}

