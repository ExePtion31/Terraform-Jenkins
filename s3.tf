resource "aws_s3_bucket" "bucket_data" {
  bucket = "${local.stack_id}-bucket-data"
  acl    = "private"

  versioning {
    enabled = true
  }
}