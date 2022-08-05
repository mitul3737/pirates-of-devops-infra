resource "aws_subnet" "public" {
  for_each          = var.public_subnets
  cidr_block        = each.key
  availability_zone = "${data.aws_region.current.name}${lookup(each.value, "az")}"
  vpc_id            = aws_vpc.main.id

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name         = "${local.resource_name_prefix}-public-${lookup(each.value, "az")}"
    Environment  = var.project_info[0]
    Project      = var.project_info[1]
    ResourceType = "SUBNET"
    Developer    = var.project_info[2]
  }

}

resource "aws_subnet" "private" {
  for_each          = var.private_subnets
  cidr_block        = each.key
  availability_zone = "${data.aws_region.current.name}${lookup(each.value, "az")}"
  vpc_id            = aws_vpc.main.id

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name                                                              = "${local.resource_name_prefix}-private-${lookup(each.value, "az")}"
    Environment                                                       = var.project_info[0]
    Project                                                           = var.project_info[1]
    ResourceType                                                      = "SUBNET"
    Developer                                                         = var.project_info[2]
    "kubernetes.io/cluster/${local.resource_name_prefix}-cluster" = "shared" //TODO: Remove dependency
  }

}