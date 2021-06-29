packer {
  required_plugins {
    #https://github.com/hashicorp/packer-plugin-amazon
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name          = "packer_ubuntu16"
  instance_type     = "t2.micro"
  region            = "us-east-1"
  security_group_id = "sg-06592cd4026668f7a"
  subnet_id         = "subnet-0178e989900bc2231"
  vpc_id            = "vpc-05cfc2eeadfda8ce7"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  iam_instance_profile = "SessionManagerInstanceProfile"
  ssh_username = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu"]
}

