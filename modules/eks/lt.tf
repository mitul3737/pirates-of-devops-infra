resource "aws_launch_template" "node" {
  name = "${local.resource_name_prefix}-node"
  iam_instance_profile {
    arn = aws_iam_instance_profile.eks-node.arn
  }
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 100
      volume_type = "gp3"
      throughput  = 125
      iops        = 3000
    }
  }
  image_id                             = data.aws_ssm_parameter.eks-ami.value
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.node_instance_type
  key_name                             = aws_key_pair.keypair.key_name
  vpc_security_group_ids               = [aws_security_group.node.id]
  user_data                            = base64encode(var.user_data)
  tags = {
    Name = "${local.resource_name_prefix}-node"
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name                                = "${local.resource_name_prefix}-node"
      "kubernetes.io/cluster/${local.resource_name_prefix}" = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      Name = "${local.resource_name_prefix}-node"
    }
  }
  lifecycle {
    prevent_destroy = false
  }
}