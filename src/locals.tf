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

  eks_versions = {
    dev = "1.22"
  }
  eks-version = local.eks_versions[local.env]

  cluster-max-size = 2
  cluster-min-size = 1

  spot_allocation_strategies = {
    dev = "lowest-price"
  }
  spot-allocation-strategy = local.spot_allocation_strategies[local.env]

  on_demand_percentage = {
    dev = 0
  }
  on-demand-percentage = local.on_demand_percentage[local.env]

  worker_instance_types = {
    dev = [
      { name = "t3.medium", weight = "1" },
    ]
  }
  worker-instance-types = local.worker_instance_types[local.env]

  worker_keypairs = {
    dev = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwgc+j3mmM8QDF7XnVvvcMxJn50KtvmpAca5Nups7CBe0UFCy029k4KdpHGKypRZq0Cx+1WmcPdNvLfNArsRoZC8JzQg4W4XzXy9ZBpWR92RE4f/J+dPp7ezh0U4+SOahyRSdMLej1BDlOHa69LUjoMo4qEQji76LcqwyPbykJbrVmDC6u6xI3KYW6X86+AI+gFw5JhsP+v9FHYeYw3pPe4OnWF/ucWFcOx1d7VKEcbWeJhLXmNhOUytBb+zMzqkBT8Mi3pEFpHLlsp/C1NGJo+43/r7taGPhLwQLhlnsBTFfqsbhT+XphMJGTfiOTPBO9UC/Kq/uHBxWITEuwPQI33CNMSLvdzmxeMInhPlSOhjpJUnmTS3w4uCjHWaQZ/XLs8ztlleGhTYiCSbEFYFETjLSAFB9OamQi+nATdiZU+hAeftCA0jOXH6hr3sb+67GkDxaeOQ+PJi3vEUVE83X0v7LAxQLN2aunSe4CZa4H6esxIVcnmG1Z48CHkPTfNAk="
  }
  worker-keypair = local.worker_keypairs[local.env]

  eks_worker_node_userdata = {
    dev = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${module.eks.endpoint}' --b64-cluster-ca '${module.eks.certificate_authority[0].data}' '${module.eks.cluster_name}'
USERDATA
    prd = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${module.eks.endpoint}' --b64-cluster-ca '${module.eks.certificate_authority[0].data}' '${module.eks.cluster_name}'
USERDATA
  }
  eks-worker-node-userdata = local.eks_worker_node_userdata[local.env]


}