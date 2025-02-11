provider "aws" {
  region = var.aws_region
}

module "sqs" {
  source = "./modules/sqs"
  queue_name = var.queue_name
}

module "s3" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}

module "lambda" {
  source = "./modules/lambda"
  function_name = "processSQSMessage"
  s3_bucket = module.s3.bucket_name
}

module "api_gateway" {
  source = "./modules/api_gateway"
  lambda_function_arn = module.lambda.function_arn
}

module "ecs" {
  source = "./modules/ecs"
  api_gateway_url = module.api_gateway.api_gateway_url
}