output "lambda_arn" {
  value = aws_lambda_function.default.arn
}

output "lambda_name" {
  value = var.lambda_function_name
}
