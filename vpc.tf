module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.env_name}-${local.client}-vpc"
  cidr = local.cidr

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_nat_gateway    = true
  enable_vpn_gateway    = false
  single_nat_gateway    = true
  enable_dns_hostnames  = true

  tags = local.common_tags
}