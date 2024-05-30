# variable "bucket_name" {
# }

# variable "s3_prefix" {
# }

variable "cloudwatchlogs_retention" {
  default = 30
}

variable "lambda_function_name" {
}

variable "lambda_handler" {
  default = "lambda_handler"
}

variable "lambda_memory" {
  default = 128
}

variable "lambda_runtime" {
  default = "python3.9"
}

variable "lambda_timeout" {
  default = 10
}

# variable "event" {
# }