resource "aws_s3_bucket" "bucket_data" {
  bucket = "${var.stack_id}-bucket-data"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = local.common_tags
}