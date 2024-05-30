data "aws_caller_identity" "current" {}

resource "aws_cloudwatch_log_group" "default" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.cloudwatchlogs_retention
}

resource "aws_lambda_function" "default" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  filename      = "${path.module}/function/provider_inbox_s3_trigger.zip"

  handler = var.lambda_handler
  runtime = var.lambda_runtime

  memory_size = var.lambda_memory
  timeout     = var.lambda_timeout

  tags = {
    Name  = var.lambda_function_name
    owner = "terraform"
  }
}
