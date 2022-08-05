data "aws_ssm_parameter" "eks-ami" {
  name = "/aws/service/eks/optimized-ami/${var.eks_version}/amazon-linux-2/recommended/image_id"
}
