resource "aws_iam_role" "lambda_role" {
  name               = "${var.lambda_function_name}-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {

    sid     = "AssumePolicy"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "default_policy" {
  statement {
    sid    = "CreateLogs"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }

  statement {
    sid    = "PutLogs"
    effect = "Allow"
    actions = [
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*log-group:/aws/lambda/${var.lambda_function_name}:*"
    ]
  }
}

resource "aws_iam_policy" "default_policy" {
  name   = "${var.lambda_function_name}-lambda-default"
  policy = data.aws_iam_policy_document.default_policy.json
}

resource "aws_iam_role_policy_attachment" "default_policy_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.default_policy.arn
}