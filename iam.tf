# Lambda Trigger
resource "aws_iam_role" "lambda_trigger_role" {
  name               = "${local.stack_id}-signed-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_trigger_assume_role_policy_document.json
}

# Lambda Trigger Cloudwatch policy
resource "aws_iam_policy" "lambda_trigger_logs_policy" {
  name = "${local.stack_id}-lambda-trigger-logs"
  policy = data.aws_iam_policy_document.lambda_trigger_assume_logs_policy_document.json
}

resource "aws_iam_role_policy_attachment" "lambda_trigger_logs_policy_attachment" {
  role       = aws_iam_role.lambda_trigger_role.name
  policy_arn = aws_iam_policy.lambda_trigger_logs_policy.arn
}