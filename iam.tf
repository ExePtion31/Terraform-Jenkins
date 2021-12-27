# Cloudwatch Lambda
resource "aws_iam_policy" "logging_policy" {
  name        = "${var.stack_id}-log-policy"
  description = "Log Policy"
  path        = "/"
  policy      = data.aws_iam_policy_document.logging_policy_document.json
}

resource "aws_iam_role_policy_attachment" "logs_policy_attachment" {
  role       = aws_iam_role.signed_lambda_role.name
  policy_arn = aws_iam_policy.logging_policy.arn
}

# Lambda 
resource "aws_iam_role" "signed_lambda_role" {
  name               = "${var.stack_id}-signed-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy_document.json
}

