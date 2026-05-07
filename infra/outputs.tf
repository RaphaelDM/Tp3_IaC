output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "private_subnet_id" {
  value = module.network.private_subnet_id
}

output "bucket_id" {
  value = module.storage.bucket_id
}

output "bucket_arn" {
  value = module.storage.bucket_arn
}