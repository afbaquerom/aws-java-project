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
}

module "api_gateway" {
  source = "./modules/api_gateway"
}

module "ecs" {
  source = "./modules/ecs"
}