variable "vpc_cidr" {
  description = "CIDR block du VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Environnement (dev, staging, prod)"
  type        = string
}

variable "tags" {
  description = "Tags communs"
  type        = map(string)
  default     = {}
}