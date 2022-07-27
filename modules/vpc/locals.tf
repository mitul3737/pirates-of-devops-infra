data "aws_region" "current" {}

locals {

  resource_name_prefix = "${var.project_info[0]}-${var.project_info[1]}"

}
