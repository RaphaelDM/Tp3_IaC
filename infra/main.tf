locals {
  common_tags = {
    project     = var.project
    environment = var.environment
    managed_by  = "terraform"
  }
}

# data "aws_caller_identity" "current" {}

module "network" {
  source      = "./modules/network"
  environment = var.environment
  tags        = local.common_tags
}

module "storage" {
  source      = "./modules/storage"
  bucket_name = "tp3-data-${var.environment}-rd"
  tags        = local.common_tags
}