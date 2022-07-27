resource "aws_vpc" "main" {

  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name         = "${local.resource_name_prefix}-vpc"
    Environment  = var.project_info[0]
    Project      = var.project_info[1]
    ResourceType = "VPC"
    Developer    = var.project_info[2]
  }

}

resource "aws_vpc_dhcp_options" "main" {

  domain_name         = var.domain_name
  domain_name_servers = var.domain_name_servers

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name         = "${local.resource_name_prefix}-vpc"
    Environment  = var.project_info[0]
    Project      = var.project_info[1]
    ResourceType = "DHCP"
    Developer    = var.project_info[2]
  }

}

resource "aws_vpc_dhcp_options_association" "main" {

  dhcp_options_id = aws_vpc_dhcp_options.main.id
  vpc_id          = aws_vpc.main.id

  lifecycle {
    prevent_destroy = false
  }
}
