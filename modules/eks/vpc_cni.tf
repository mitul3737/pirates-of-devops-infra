resource "aws_eks_addon" "cni" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "vpc-cni"
}