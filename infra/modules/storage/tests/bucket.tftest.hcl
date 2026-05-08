run "test_bucket_creation" {
  command = plan

  variables {
    bucket_name = "test-bucket-tp3"
    tags = {
      environment = "test"
      managed_by  = "terraform"
      project     = "tp3"
    }
  }

  assert {
    condition     = aws_s3_bucket_versioning.main.versioning_configuration[0].status == "Enabled"
    error_message = "Le versioning doit être activé"
  }

  assert {
    condition     = contains([for r in aws_s3_bucket_server_side_encryption_configuration.main.rule : [for a in r.apply_server_side_encryption_by_default : a.sse_algorithm][0]], "AES256")
    error_message = "Le chiffrement AES256 doit être configuré"
  }
}

run "test_invalid_name" {
  command = plan

  variables {
    bucket_name = ""
    tags        = {}
  }

  expect_failures = [
    var.bucket_name
  ]
}
