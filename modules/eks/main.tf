resource "aws_eks_cluster" "main" {
  depends_on = [aws_iam_role.cluster]
  name       = "${local.resource_name_prefix}-cluster"
  role_arn   = aws_iam_role.cluster.arn
  version    = var.eks_version
  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = [aws_security_group.cluster.id]
    endpoint_private_access = true
    endpoint_public_access  = false
  }
  enabled_cluster_log_types = ["api", "audit"]
  lifecycle {
    prevent_destroy = false
  }
}

