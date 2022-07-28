resource "kubernetes_config_map" "aws-auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<ROLES
- rolearn: "${var.node_iam_role_arn}"
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
ROLES
  }

}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.default_namespace
  }
}
