output "endpoint" {
  value = aws_eks_cluster.main.endpoint
}
output "certificate_authority" {
  value = aws_eks_cluster.main.certificate_authority
}
output "cluster_name" {
  value = aws_eks_cluster.main.name
}
output "node_iam_role_arn" {
  value = aws_iam_role.node.arn
}
output "cluster_oidc_issuer_url" {
  value = try(aws_eks_cluster.main.identity[0].oidc[0].issuer, "")
}
output "cluster_oidc_issuer" {
  value = aws_eks_cluster.main.identity.0.oidc.0.issuer
}
output "public_alb_sg" {
  value = aws_security_group.public-alb.id
}