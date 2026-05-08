variable "bucket_name" {
  description = "Nom du bucket S3"
  type        = string
  validation {
    condition     = length(trimspace(var.bucket_name)) > 0
    error_message = "Le nom du bucket ne peut pas être vide."
  }
}

variable "tags" {
  description = "Tags communs"
  type        = map(string)
  default     = {}
}