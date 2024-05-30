locals {
  account                                = "marichka"
  environment                            = "staging"
  environment_test                       = "test"
  tsh_staging_provider_inbox_bucket_name = "${local.account}-${local.environment}-provider-inbox"
  tsh_test_provider_inbox_bucket_name    = "${local.account}-${local.environment_test}-provider-inbox"
}

module "tsh_staging_provider_inbox" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.7.0"

  bucket = local.tsh_staging_provider_inbox_bucket_name
  # acl    = "private"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  tags = {
    Name                 = local.tsh_staging_provider_inbox_bucket_name
    owner                = "terraform"
    public_read_allowed  = "false"
    public_write_allowed = "false"
  }
}

module "tsh_test_provider_inbox_bucket_name" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.7.0"

  bucket = local.tsh_test_provider_inbox_bucket_name
  # acl    = "private"
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  attach_policy = true
  policy        = data.aws_iam_policy_document.tsh_test_provider_inbox.json

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  tags = {
    Name                 = local.tsh_staging_provider_inbox_bucket_name
    owner                = "terraform"
    public_read_allowed  = "false"
    public_write_allowed = "false"
  }
}

module "tsh_staging_provider_inbox_bucket_notification" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/notification"
  version = "4.1.0"
  bucket  = local.tsh_staging_provider_inbox_bucket_name
  lambda_notifications = {
    lambda1 = {
      function_arn  = data.terraform_remote_state.lambda.outputs.provider_inbox_s3_trigger_lambda_arn
      function_name = data.terraform_remote_state.lambda.outputs.provider_inbox_s3_trigger_lambda_name
      events        = ["s3:ObjectCreated:Put"]
      filter_prefix = "decisionsource_dev/"
    }
    lambda2 = {
      function_arn  = data.terraform_remote_state.lambda.outputs.custom_metrics_lambda_arn
      function_name = data.terraform_remote_state.lambda.outputs.custom_metrics_lambda_name
      events        = ["s3:ObjectCreated:Put"]
      filter_prefix = "amadeus/"
    }
    lambda3 = {
      function_arn  = data.terraform_remote_state.lambda.outputs.custom_metrics_lambda_arn
      function_name = data.terraform_remote_state.lambda.outputs.custom_metrics_lambda_name
      events        = ["s3:ObjectCreated:Put"]
      filter_prefix = "hrsd/"
    }
    lambda4 = {
      function_arn  = data.terraform_remote_state.lambda.outputs.custom_metrics_lambda_arn
      function_name = data.terraform_remote_state.lambda.outputs.custom_metrics_lambda_name
      events        = ["s3:ObjectCreated:Put"]
      filter_prefix = "premier_inn/"
    }
    lambda5 = {
      function_arn  = data.terraform_remote_state.lambda.outputs.custom_metrics_lambda_arn
      function_name = data.terraform_remote_state.lambda.outputs.custom_metrics_lambda_name
      events        = ["s3:ObjectCreated:Put"]
      filter_prefix = "sabre/"
    }
  }
}
