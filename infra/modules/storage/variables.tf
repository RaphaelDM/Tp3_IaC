variable "bucket_name" {
  description = "Nom du bucket S3"
  type        = string
}

variable "tags" {
  description = "Tags communs"
  type        = map(string)
  default     = {}
}