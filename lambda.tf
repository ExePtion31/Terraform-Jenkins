resource "aws_lambda_function" "signed_lambda" {
  function_name    = "${var.stack_id}-signed"
  role             = aws_iam_role.signed_lambda_role.arn
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  source_code_hash = filebase64sha256(var.PATH_TO_LAMBDA["zip"])
  filename         = var.PATH_TO_LAMBDA["zip"]

  depends_on = [
    aws_cloudwatch_log_group.lambda_signed_log_group,
  ]

  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash
    ]
  }
}