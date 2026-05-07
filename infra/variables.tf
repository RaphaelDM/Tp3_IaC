variable "environment" {
  description = "Environnement (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Nom du projet"
  type        = string
  default     = "tp3"
}