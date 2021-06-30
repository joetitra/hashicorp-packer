packer {
  required_plugins {
    #https://github.com/hashicorp/packer-plugin-amazon
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "windows" {
  ami_name      = "packer_server2019"
  instance_type = "m3.large"
  region        = "us-east-1"
  security_group_id = "<SECURITYGROUP>"
  subnet_id         = "<SUBNET>"
  vpc_id            = "<VPC>"
  source_ami_filter {
    filters = {
      name                = "*Windows_Server-2019-English-Full-Base*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  user_data_file = "./bootstrap_win.txt"
  communicator   = "winrm"
  winrm_insecure = true
  winrm_username = "Administrator"
  winrm_use_ssl  = true
}

build {
  sources = ["source.amazon-ebs.windows"]
  provisioner "powershell" {
    inline = [
      "C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Scripts\\InitializeInstance.ps1 -Schedule",
      "C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Scripts\\SysprepInstance.ps1 -NoShutdown"
    ]
  }
}
