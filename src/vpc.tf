module "vpc" {
  source = "../modules/vpc"
  providers = { aws = aws.piratesofdevops }

  vpc_cidr_block  = local.vpc-cidr
  domain_name     = local.vpc-domain-name
  public_subnets  = local.public-subnets
  private_subnets = local.private-subnets

  project_info = [
    local.env,
    local.project,
    local.developer
  ]
}