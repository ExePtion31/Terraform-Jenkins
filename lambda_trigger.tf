resource "aws_lambda_permission" "signed_lambda_trigger_permission" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_trigger.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket_data.arn
  depends_on    = [aws_lambda_function.lambda_trigger, aws_s3_bucket.bucket_data]
}

resource "aws_s3_bucket_notification" "bucket_data_notification" {
  bucket = aws_s3_bucket.bucket_data.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda_trigger.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".txt"
  }
}