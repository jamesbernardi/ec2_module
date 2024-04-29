data "aws_availability_zones" "available" {
  state = "available"
}


data "aws_vpcs" "vpc" {
  tags = {
    Name = "*${var.vpc_name}*"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}*private*"]
  }
}

data "aws_security_groups" "security_groups" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.vpc.ids[0]]
  }
  tags = {
    Name = "${var.vpc_name}-ecs-application"
  }
}
