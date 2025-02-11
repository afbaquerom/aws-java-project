output "api_gateway_endpoint" {
  value = aws_api_gateway_deployment.api_gateway.invoke_url
}

output "s3_bucket_url" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
}

output "sqs_queue_url" {
  value = aws_sqs_queue.queue.id
}

output "lambda_function_name" {
  value = aws_lambda_function.lambda_function.function_name
}