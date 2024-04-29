resource "aws_security_group" "ec2" {
  name_prefix = "ec2--importer"
  vpc_id      = data.aws_vpcs.vpc.ids[0]
  tags = {
    Name = "ec2"
  }
}

resource "aws_security_group_rule" "ec2_out" {
  security_group_id = aws_security_group.ec2.id
  for_each          = toset(["22", "443", "80"])
  type              = "egress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

data "aws_ssm_parameter" "amazon_linux_3" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

resource "aws_instance" "ec2" {
  ami                         = data.aws_ssm_parameter.amazon_linux_3.value
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnets.private.ids[0]
  vpc_security_group_ids      = [aws_security_group.ec2.id, join(",", data.aws_security_groups.security_groups.ids)]
  associate_public_ip_address = false
  monitoring                  = false
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name

  root_block_device {
    volume_size = "200"
  }
  tags = {
    Name = var.vpc_name
  }

}

resource "aws_ssm_association" "install_base_packages" {
  name = aws_ssm_document.base_packages_al2023.name
  targets {
    key    = "InstanceIds"
    values = [aws_instance.ec2.id]
  }
  document_version = "$LATEST"
}
