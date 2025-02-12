resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_gateway_name
  description = "API Gateway for the application"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "myresource"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.ecs_service_name}-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                   = var.ecs_service_name
  network_mode             = "awsvpc"
  requires_compatibilities  = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = var.ecs_service_name
    image     = "nginx:latest"
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }]
  }])
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = ["subnet-12345678"]  # Replace with your subnet IDs
    security_groups  = ["sg-12345678"]      # Replace with your security group IDs
    assign_public_ip = true
  }
}

resource "aws_sqs_queue" "sqs_queue" {
  name = var.sqs_queue_name
}

resource "aws_lambda_function" "lambda_function" {
  function_name = var.lambda_function_name
  s3_bucket     = var.s3_bucket_name
  s3_key        = "lambda_function.zip"  # Replace with your actual S3 key
  handler       = "index.handler"
  runtime       = "nodejs14.x"  # Replace with your desired runtime
  role          = aws_iam_role.lambda_exec.arn
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = var.cloudwatch_log_group
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.lambda_function_name}-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Effect    = "Allow"
      Sid       = ""
    }]
  })
}

resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "${var.lambda_function_name}-policy-attachment"
  roles      = [aws_iam_role.lambda_exec.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}