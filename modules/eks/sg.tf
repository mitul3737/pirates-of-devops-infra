data "aws_subnet" "default" {
  id = var.subnet_ids[0]
}

resource "aws_security_group" "node" {
  name   = "${local.resource_name_prefix}-node-sg"
  vpc_id = data.aws_subnet.default.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    ignore_changes = [ingress]
  }

  tags = {
    Name         = "${local.resource_name_prefix}-node-sg"
    ResourceType = "SG"
  }
}

resource "aws_security_group" "cluster" {
  name   = "${local.resource_name_prefix}-cluster-sg"
  vpc_id = data.aws_subnet.default.vpc_id
  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"] #TODO harden within vpc only
  }
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name         = "${local.resource_name_prefix}-cluster-sg"
    ResourceType = "SG"
  }
}

resource "aws_security_group" "public-alb" {
  name   = "${local.resource_name_prefix}-public-alb-sg"
  vpc_id = data.aws_subnet.default.vpc_id
  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name         = "${local.resource_name_prefix}-public-alb-sg"
    ResourceType = "SG"
  }
}
