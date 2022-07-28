terraform {
  backend "s3" {
    bucket         = "piratesofdevops-iac-state"
    key            = "keyfiles"
    region         = "ap-southeast-1"
    dynamodb_table = "piratesofdevops-iac-state"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}


provider "helm" {
  kubernetes {
    host                   = module.eks.endpoint
    cluster_ca_certificate = base64decode(module.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.medlify.token
  }
}

provider "kubernetes" {
  host                   = module.eks.endpoint
  cluster_ca_certificate = base64decode(module.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.medlify.token
}
