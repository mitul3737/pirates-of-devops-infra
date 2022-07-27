locals {
  env       = terraform.workspace
  project   = "piratesofdevops"
  developer = "devops"

  vpc_domain_names = {
    dev = "piratesofdevops.net"
  }
  vpc-domain-name = lookup(local.vpc_domain_names, local.env)

  vpc_cidr_blocks = {
    dev = "10.10.0.0/20"
  }
  vpc-cidr = lookup(local.vpc_cidr_blocks, local.env)

  public_subnets = {
    dev = {
      "10.10.1.0/24" = { az = "a" }
      "10.10.2.0/24" = { az = "b" }
      "10.10.3.0/24" = { az = "c" }
    }
  }
  public-subnets = lookup(local.public_subnets, local.env)

  private_subnets = {
    dev = {
      "10.10.4.0/24" = { az = "a" }
      "10.10.5.0/24" = { az = "b" }
      "10.10.6.0/24" = { az = "c" }
    }
  }
  private-subnets = lookup(local.private_subnets, local.env)

}