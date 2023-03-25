locals {
############# For Client #########################

  env_name = "development"
  client = "express"
  aws_account = " 4********73 "

######## For VPC

  cidr            = "172.19.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["172.19.1.0/24", "172.19.2.0/24", "172.19.3.0/24"]
  public_subnets  = ["172.19.101.0/24", "172.19.102.0/24", "172.19.103.0/24"]

  
############# For tags #################
  common_tags = {
      client       = local.client
      environment   = local.env_name
      Terraform     = "true"
      account-id    = local.aws_account
  }
}