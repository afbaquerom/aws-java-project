provider "aws" {
  region = var.aws_region
}

module "sqs" {
  source = "./modules/sqs"
}

module "s3" {
  source = "./modules/s3"
}

module "lambda" {
  source = "./modules/lambda"
  s3_bucket = module.s3.bucket_name
}

module "api_gateway" {
  source = "./modules/api_gateway"
  lambda_function_arn = module.lambda.function_arn
}

module "ecs" {
  source = "./modules/ecs"
}