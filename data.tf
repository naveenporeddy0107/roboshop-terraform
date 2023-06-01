data "aws_ami" "centos" {
  most_recent = true
  owners = ["973714476881"]
}

data "aws_security_group" "allow-all" {
  name="allow-all"
}