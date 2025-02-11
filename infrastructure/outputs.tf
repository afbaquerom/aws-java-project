output "api_gateway_endpoint" {
  value = aws_api_gateway_deployment.example.invoke_url
}

output "sqs_queue_url" {
  value = aws_sqs_queue.example.id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.example.bucket
}

output "lambda_function_name" {
  value = aws_lambda_function.example.function_name
}

output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.example.name
}