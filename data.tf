#Zip
data "archive_file" "zip_lambda" {
  type = "zip"
  source_file = var.PATH_TO_LAMBDA["unzip"]
  output_path = var.PATH_TO_LAMBDA["zip"]
}

# Lambda role document
data "aws_iam_policy_document" "lambda_trigger_assume_role_policy_document" {
  statement {
    sid = "LambdaTriggerPolicy"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
  
  statement {
    sid = "LambdaTriggerLogs"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}
