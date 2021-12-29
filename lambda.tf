resource "aws_lambda_function" "lambda_trigger" {
  function_name    = "${var.stack_id}-signed"
  role             = aws_iam_role.lambda_trigger_role.arn
  handler          = "index.handler"
  runtime          = "nodejs12.x"
  source_code_hash = "${data.archive_file.zip_lambda.output_base64sha256}"
  filename         = var.path_lambda["zip"]

  depends_on = [
    aws_cloudwatch_log_group.lambda_signed_log_group,
  ]

  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash
    ]
  }

  tags = local.common_tags
}