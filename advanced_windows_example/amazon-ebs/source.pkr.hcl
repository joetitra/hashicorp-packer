//Source File
locals {
  instance_type        = "m3.large"
  security_group_id    = ""
  subnet_id            = ""
  vpc_id               = ""
  iam_instance_profile = ""
  user_data_file       = "../common_files/windows/unattend/bootstrap_win.txt"
  script_file          = "../common_files/windows/scripts/createFileOnDesktop.ps1"
  inline_command = [
    "C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Scripts\\InitializeInstance.ps1 -Schedule",
    "C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Scripts\\SysprepInstance.ps1 -NoShutdown"
  ]
}

source "amazon-ebs" "server2016" {
  instance_type        = local.instance_type
  region               = var.aws_region
  security_group_id    = local.security_group_id
  subnet_id            = local.subnet_id
  vpc_id               = local.vpc_id
  iam_instance_profile = local.iam_instance_profile
  user_data_file       = local.user_data_file
  communicator         = "winrm"
  winrm_username       = "Administrator"
  winrm_use_ssl        = true
}

source "amazon-ebs" "server2019" {
  instance_type        = local.instance_type
  region               = var.aws_region
  security_group_id    = local.security_group_id
  subnet_id            = local.subnet_id
  vpc_id               = local.vpc_id
  iam_instance_profile = local.iam_instance_profile
  user_data_file       = local.user_data_file
  communicator         = "winrm"
  winrm_username       = "Administrator"
  winrm_use_ssl        = true
}
