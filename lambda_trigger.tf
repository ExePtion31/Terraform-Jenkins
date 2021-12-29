resource "aws_lambda_permission" "signed_lambda_trigger_permission" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_trigger.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket_data.arn
  depends_on    = [aws_lambda_function.lambda_trigger, aws_s3_bucket.bucket_data]
}