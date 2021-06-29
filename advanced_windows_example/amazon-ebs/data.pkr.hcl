// Data Sources
data "amazon-ami" "server2016" {
  filters = {
    name                = "*Windows_Server-2016-English-Full-Base*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  owners      = ["amazon"]
  most_recent = true
  region      = var.aws_region
}

data "amazon-ami" "server2019" {
  filters = {
    name                = "*Windows_Server-2019-English-Full-Base*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  owners      = ["amazon"]
  most_recent = true
  region      = var.aws_region
}
