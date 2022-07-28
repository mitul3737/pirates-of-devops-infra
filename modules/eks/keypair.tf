resource "aws_key_pair" "keypair" {
  public_key = var.node_public_key
  key_name   = "${local.resource_name_prefix}-node-key"
  lifecycle {
    prevent_destroy = false
  }
  //TODO Need to add support for tags
}