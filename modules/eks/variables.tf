variable "project_info" {
  type = list(string)
}
variable "subnet_ids" {
  type = list(string)
}
variable "eks_version" {
  type = string
}
variable "node_public_key" {
  type = string
}
variable "node_instance_type" {
  type    = string
  default = "m5.xlarge"
}
variable "cluster_max_size" {
  type = number
}
variable "cluster_min_size" {
  type = number
}

variable "additional_iam_policies" {
  type = map(string)
}

// asg
variable "node_instance_types" {
}
variable "spot_instance_pools" {
  type    = number
  default = "2"
}
variable "spot_allocation_strategy" {}

variable "on_demand_percentage" {
  default = 70
  type    = number
}
variable "scale-up-policy" {
  default = false
  type    = bool
}
variable "scale-down-policy" {
  default = false
  type    = bool
}

variable "user_data" {}



