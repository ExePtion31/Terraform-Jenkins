# Lambda Trigger
resource "aws_iam_role" "lambda_trigger_role" {
  name               = "${var.stack_id}-signed-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_trigger_assume_role_policy_document.json
}