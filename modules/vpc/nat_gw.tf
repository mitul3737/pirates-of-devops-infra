resource "aws_nat_gateway" "main" {

  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public[keys(var.public_subnets)[0]].id

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name         = "${local.resource_name_prefix}-natgw"
    Environment  = var.project_info[0]
    Project      = var.project_info[1]
    ResourceType = "NATGW"
    Developer    = var.project_info[2]
  }

}
