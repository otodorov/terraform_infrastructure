resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]} VPC" },
  )
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]} IGW" },
  )
}

resource "aws_subnet" "public_subnets" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.vpc_public_subnet_ip_ranges)
  cidr_block        = var.vpc_public_subnet_ip_ranges[count.index]
  availability_zone = var.vpc_availability_zones[count.index % length(var.vpc_availability_zones)]
  tags = merge(
    var.default_tags,
    var.custom_tags,
    var.vpc_public_subnet_tags[count.index],
  )
}

resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.vpc_private_subnet_ip_ranges)
  cidr_block        = var.vpc_private_subnet_ip_ranges[count.index]
  availability_zone = var.vpc_availability_zones[count.index % length(var.vpc_availability_zones)]
  tags = merge(
    var.default_tags,
    var.custom_tags,
    var.vpc_private_subnet_tags[count.index],
  )
}

resource "aws_default_route_table" "vpc_route_table_default" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]}-default-table" },
  )
}

resource "aws_route_table" "vpc_public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]}-route-table-public" },
  )
}

resource "aws_route" "prublic_default_route" {
  gateway_id             = aws_internet_gateway.vpc_igw.id
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.vpc_public_route_table.id
}

resource "aws_route_table" "vpc_private_route_tables" {
  count  = length(var.vpc_availability_zones)
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]}-private-route-${substr(var.vpc_availability_zones[count.index], -1, 0)}" },
  )
}

resource "aws_route" "private_default_route" {
  count                  = length(var.vpc_availability_zones)
  nat_gateway_id         = aws_nat_gateway.nat_gateway[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.vpc_private_route_tables[count.index].id
}

resource "aws_route_table_association" "public_subnet_route_table" {
  count = length(var.vpc_public_subnet_ip_ranges)

  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.vpc_public_route_table.id
}

resource "aws_route_table_association" "private_subnet_route_table" {
  count = length(var.vpc_private_subnet_ip_ranges)

  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.vpc_private_route_tables[count.index % length(var.vpc_availability_zones)].id
}

resource "aws_eip" "nat_eip" {
  count = length(var.vpc_public_subnet_ip_ranges)
  vpc   = true
  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]} EIP for AZ-${substr(var.vpc_availability_zones[count.index], -1, 0)}" },
  )
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.vpc_availability_zones)
  subnet_id     = aws_subnet.public_subnets[count.index].id
  allocation_id = aws_eip.nat_eip[count.index].id
  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]}-NAT_GW-${substr(var.vpc_availability_zones[count.index], -1, 0)}" },
  )
}

resource "aws_vpc_dhcp_options" "dhcp_options" {
  domain_name         = var.vpc_domain_name
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]} DHCP Options" },
  )
}

resource "aws_vpc_dhcp_options_association" "vpc_dhcp_association" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options.id
}
