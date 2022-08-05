resource "aws_autoscaling_group" "node" {
  capacity_rebalance        = true
  name                      = "${local.resource_name_prefix}-node"
  min_size                  = var.cluster_min_size
  desired_capacity          = var.cluster_min_size
  max_size                  = var.cluster_max_size
  default_cooldown          = "180"
  health_check_grace_period = "90"
  health_check_type         = "ELB"
  force_delete              = true
  termination_policies      = ["OldestInstance", "OldestLaunchTemplate"]
  vpc_zone_identifier       = var.subnet_ids
  enabled_metrics           = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  //  tags                      = var.tags // TODO Implement Tags
  tags = [
    {
      key                 = "k8s.io/cluster-autoscaler/${local.resource_name_prefix}-cluster"
      value               = "owned"
      propagate_at_launch = true
    },
    {
      key                 = "k8s.io/cluster-autoscaler/enabled"
      value               = "true"
      propagate_at_launch = true
    }
  ]
  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.node.id
        version            = "$Latest"
      }
      dynamic "override" {
        for_each = var.node_instance_types
        content {
          instance_type     = var.node_instance_types[override.key]["name"]
          weighted_capacity = var.node_instance_types[override.key]["weight"]
        }
      }
    }
    instances_distribution {
      on_demand_base_capacity                  = "0"
      on_demand_allocation_strategy            = "prioritized"
      on_demand_percentage_above_base_capacity = var.on_demand_percentage
      spot_instance_pools                      = var.spot_instance_pools
      spot_allocation_strategy                 = var.spot_allocation_strategy
    }
  }
  lifecycle {
    ignore_changes        = [target_group_arns]
    create_before_destroy = true
  }
}
