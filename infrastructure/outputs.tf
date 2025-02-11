output "api_gateway_endpoint" {
  value = aws_api_gateway_deployment.api_gateway.invoke_url
}

output "s3_bucket_name" {
  value = aws_s3_bucket.file_bucket.bucket
}

output "sqs_queue_url" {
  value = aws_sqs_queue.queue.id
}

output "lambda_function_name" {
  value = aws_lambda_function.file_creator.function_name
}