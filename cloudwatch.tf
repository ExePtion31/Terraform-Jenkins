resource "aws_cloudwatch_log_group" "lambda_signed_log_group" {
  name              = "/aws/lambda/${local.stack_id}-signed"
  retention_in_days = 30
}