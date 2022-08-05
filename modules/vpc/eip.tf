resource "aws_eip" "main" {

  vpc = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name         = "${local.resource_name_prefix}-eip"
    Environment  = var.project_info[0]
    Project      = var.project_info[1]
    ResourceType = "EIP"
    Developer    = var.project_info[2]
  }

}