resource "aws_api_gateway_rest_api" "api" {
  name        = "my-api"
  description = "API for processing names and storing files in S3"
}

resource "aws_api_gateway_resource" "names" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "names"
}

resource "aws_api_gateway_method" "post_names" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.names.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "sqs_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.names.id
  http_method             = aws_api_gateway_method.post_names.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:sqs:path/${aws_sqs_queue.names_queue.name}"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [aws_api_gateway_integration.sqs_integration]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}