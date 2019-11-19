# provider aws settings
aws_profile          = "emp_jungle"
aws_region           = "eu-west-2"
aws_credentials_file = "~/.aws/credentials"

#ec2_key_name = "otodorov"
custom_tags = {
  "Name" = "Challenge"
}

vpc_domain_name = "challenge.local"
vpc_cidr_block  = "10.33.32.0/19"
vpc_public_subnet_tags = [
  {
    "Name" = "challenge_public_A"
  },
  {
    "Name" = "challenge_public_B"
  },
]
vpc_public_subnet_ip_ranges = ["10.33.32.0/25", "10.33.32.128/25"]
vpc_private_subnet_ip_ranges = [
  "10.33.33.0/24", "10.33.34.0/24", # Application subnet
  "10.33.35.0/24", "10.33.36.0/24", # DB subnet
]
vpc_private_subnet_tags = [
  { "Name" = "challenge_app_A" },
  { "Name" = "challenge_app_B" },
  { "Name" = "challenge_db_A" },
  { "Name" = "challenge_db_B" },
]

vpc_availability_zones = ["a", "b"]
