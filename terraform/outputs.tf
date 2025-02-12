variable "api_gateway_id" {
  description = "The ID of the API Gateway"
}

variable "ecs_service_id" {
  description = "The ID of the ECS service"
}

variable "sqs_queue_url" {
  description = "The URL of the SQS queue"
}

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function"
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
}

variable "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch log group"
}