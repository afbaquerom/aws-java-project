variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "api_gateway_name" {
  description = "The name of the API Gateway"
  type        = string
  default     = "MyApiGateway"
}

variable "sqs_queue_name" {
  description = "The name of the SQS queue"
  type        = string
  default     = "MySQSQueue"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
  default     = "MyLambdaFunction"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-s3-bucket-unique-name"
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
  default     = "MyECSService"
}

variable "ecs_task_definition_name" {
  description = "The name of the ECS task definition"
  type        = string
  default     = "MyECSTaskDefinition"
}