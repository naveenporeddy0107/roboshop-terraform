variable "components" {
  default=["frontend","cart","catalogue"]
}

variable "instance_type"{
  default="t2.small"
}
data "aws_ami" "centos" {
  most_recent = true
  owners = ["973714476881"]
}

data "aws_security_group" "allow-all" {
  name="allow-all"
}


resource "aws_instance" "instance" {
  count=length(var.components)
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

  tags = {
    Name = var.components[count.index]
  }
}

resource "aws_route53_record" "routerecords" {
  zone_id = "Z0849970P5LI08J61JCE"
  name    = "${var.components[count.index]}-dev.naveendevops.tech"
  type    = "A"
  ttl     = 30
  records = [aws_instance."${var.components[count.index]}".private_ip ]
}