resource "aws_s3_bucket" "bucket_data" {
  bucket = "${var.stack_id}-bucket-data"
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_notification" "bucket_data_notification" {
  bucket = aws_s3_bucket.bucket_data.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.signed_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".json"
  }
}