output "provider_inbox_s3_trigger_lambda_arn" {
  value = module.mko-provider-inbox-s3-trigger.lambda_arn
}

output "provider_inbox_s3_trigger_lambda_name" {
  value = module.mko-provider-inbox-s3-trigger.lambda_name
}

output "custom_metrics_lambda_arn" {
  value = module.mko-custom-metrics.lambda_arn
}

output "custom_metrics_lambda_name" {
  value = module.mko-custom-metrics.lambda_name
}