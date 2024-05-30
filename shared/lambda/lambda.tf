module "mko-provider-inbox-s3-trigger" {
  source = "../../aws-provider-inbox-s3-trigger"
  lambda_function_name = "provider-inbox-s3-trigger"
  lambda_handler       = "provider-inbox-s3-trigger.lambda_handler"
  lambda_runtime       = "python3.9"
}

module "mko-custom-metrics" {
  source               = "../../aws-custom-metrics"
  lambda_function_name = "custom-metrics"
  lambda_handler       = "custom-metrics.lambda_handler"
  lambda_runtime       = "python3.9"
}
