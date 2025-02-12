variable "api_gateway_id" {
  description = "The ID of the API Gateway"
  value       = aws_api_gateway_rest_api.my_api_gateway.id
}

variable "ecs_service_id" {
  description = "The ID of the ECS service"
  value       = aws_ecs_service.my_ecs_service.id
}

variable "sqs_queue_url" {
  description = "The URL of the SQS queue"
  value       = aws_sqs_queue.my_sqs_queue.id
}

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.my_lambda_function.arn
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.my_s3_bucket.arn
}

variable "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.my_log_group.name
}