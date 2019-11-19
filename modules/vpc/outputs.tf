output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_igw" {
  value = aws_internet_gateway.vpc_igw.id
}

output "vpc_public_route_table" {
  value = aws_route_table.vpc_public_route_table.id
}

output "vpc_private_route_tables" {
  value = aws_route_table.vpc_private_route_tables[*].id
}

output "public_subnets" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
  value = aws_subnet.private_subnets[*].id
}

output "private_cidr" {
  value = aws_subnet.private_subnets[*].cidr_block
}

output "public_cidr" {
  value = aws_subnet.public_subnets[*].cidr_block
}

output "nat_eips" {
  value = aws_eip.nat_eip[*].public_ip
}

output "nat_gateways" {
  value = aws_nat_gateway.nat_gateway[*].id
}
