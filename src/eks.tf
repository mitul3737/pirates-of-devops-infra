module "eks" {
  source = "../modules/eks"

  eks_version = local.eks-version
  subnet_ids  = module.vpc.private_subnet_ids

  cluster_max_size         = local.cluster-max-size
  cluster_min_size         = local.cluster-min-size
  spot_allocation_strategy = local.spot-allocation-strategy
  on_demand_percentage     = local.on-demand-percentage
  node_instance_types      = local.worker-instance-types

  user_data       = local.eks-worker-node-userdata
  node_public_key = local.worker-keypair

  additional_iam_policies = {
    AWSRoute53FullAccess = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
    AmazonEC2FullAccess  = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    AmazonSSMFullAccess  = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
  }

  project_info = [
    local.env,
    local.project,
    local.developer
  ]
}

data "aws_eks_cluster_auth" "medlify" {
  name = module.eks.cluster_name
}

module "kubeconfig" {
  source = "../modules/kubeconfig"

  eks_cluster_name          = module.eks.cluster_name
  eks_endpoint              = module.eks.endpoint
  eks_certificate_authority = module.eks.certificate_authority.0.data
  node_iam_role_arn         = module.eks.node_iam_role_arn
  default_namespace         = "${local.env}-${local.project}"
}

output "kubeconfig" {
  value = module.kubeconfig.kubeconfig
}
