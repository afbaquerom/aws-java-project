resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "aws_sqs_queue" "queue" {
  name = "my-queue"
}

resource "aws_lambda_function" "lambda" {
  function_name = "my_lambda_function"
  handler       = "com.example.LambdaHandler::handleRequest"
  runtime       = "java11"
  role          = aws_iam_role.lambda_role.arn
  s3_bucket     = aws_s3_bucket.bucket.bucket
  s3_key        = "lambda/my_lambda_function.zip"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "my_api"
  description = "API for my Java application"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "myresource"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "/aws/lambda/my_lambda_function"
}

output "api_gateway_endpoint" {
  value = "${aws_api_gateway_rest_api.api.execution_arn}/myresource"
}

output "sqs_queue_url" {
  value = aws_sqs_queue.queue.id
}