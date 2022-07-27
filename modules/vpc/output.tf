output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for subnet in keys(var.public_subnets) : aws_subnet.public[subnet].id]
}

output "private_subnet_ids" {
  value = [for subnet in keys(var.private_subnets) : aws_subnet.private[subnet].id]
}
output "private_subnet_cidr_blocks" {
  value = [for subnet in keys(var.private_subnets) : aws_subnet.private[subnet].cidr_block]
}
output "igw_id" {
  value = aws_internet_gateway.main.id
}

output "nat_gw_id" {
  value = aws_nat_gateway.main.id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}