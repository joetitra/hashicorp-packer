// Template Builder
locals {
  build_time          = regex_replace(timestamp(), "[- TZ:]", "")
  server2016_ami_id   = data.amazon-ami.server2016.id
  server2016_ami_name = join("_", [var.aws_ami_name, "2016", local.build_time])
  server2019_ami_id   = data.amazon-ami.server2019.id
  server2019_ami_name = join("_", [var.aws_ami_name, "2019", local.build_time])
}

packer {
  required_plugins {
    #https://github.com/hashicorp/packer-plugin-amazon
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

build {
  source "amazon-ebs.server2016" {
    name           = "server2016"
    ami_name       = local.server2016_ami_name
    source_ami     = local.server2016_ami_id
    winrm_insecure = true
    tags = {
      Project   = "Packer Demo"
      BuildTime = local.build_time
    }
    run_tags = {
      Name = local.server2016_ami_name
    }
  }

  source "amazon-ebs.server2019" {
    name           = "server2019"
    ami_name       = local.server2019_ami_name
    source_ami     = local.server2019_ami_id
    winrm_insecure = true
    tags = {
      Project   = "Packer Demo"
      BuildTime = local.build_time
    }
    run_tags = {
      Name = local.server2019_ami_name
    }
  }

  provisioner "powershell" {
    script = local.script_file
  }

  provisioner "powershell" {
    inline = local.inline_command
  }

  provisioner "shell-local" {
    inline = ["echo build time: '${local.build_time}'"]
  }
}
