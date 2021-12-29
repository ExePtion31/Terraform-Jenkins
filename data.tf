#Zip
data "archive_file" "zip_lambda" {
  type        = "zip"
  source_file = var.path_lambda["unzip"]
  output_path = var.path_lambda["zip"]
}

# Lambda role document
data "aws_iam_policy_document" "lambda_trigger_assume_role_policy_document" {
  statement {
    sid     = "LambdaTriggerPolicy"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_trigger_assume_logs_policy_document" {
  statement {
    sid    = "LambdaTriggerLogs"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}
