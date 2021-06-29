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
  ami_name      = "packer_server2016"
  instance_type = "m3.large"
  region        = "us-east-1"
  security_group_id = "sg-06592cd4026668f7a"
  subnet_id         = "subnet-0178e989900bc2231"
  vpc_id            = "vpc-05cfc2eeadfda8ce7"
  source_ami_filter {
    filters = {
      name                = "*Windows_Server-2016-English-Full-Base*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  iam_instance_profile = "SessionManagerInstanceProfile"
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
