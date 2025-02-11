# AWS Node.js Project

This project is a serverless application built on AWS that utilizes various services including ECS, API Gateway, SQS, Lambda, and S3. The application is designed to receive a name parameter via an API Gateway, send it to an SQS queue, trigger a Lambda function that creates a file in an S3 bucket, and log the process in CloudWatch.

## Project Structure

```
aws-nodejs-project
├── src
│   ├── index.js               # Entry point of the Node.js application
│   ├── handlers
│   │   └── lambdaHandler.js    # Lambda function handler for processing SQS messages
│   ├── services
│   │   └── sqsService.js       # Service for sending messages to SQS
│   └── utils
│       └── logger.js           # Logger utility for logging information
├── infrastructure
│   ├── main.tf                 # Main Terraform configuration file
│   ├── variables.tf            # Input variables for Terraform
│   ├── outputs.tf              # Outputs of the Terraform configuration
│   └── modules
│       ├── ecs
│       │   └── ecs.tf          # ECS service and task definitions
│       ├── api_gateway
│       │   └── api_gateway.tf   # API Gateway configuration
│       ├── sqs
│       │   └── sqs.tf          # SQS queue configuration
│       ├── lambda
│       │   └── lambda.tf       # Lambda function configuration
│       └── s3
│           └── s3.tf           # S3 bucket configuration
├── tests
│   ├── unit
│   │   └── index.test.js       # Unit tests for index.js
│   └── integration
│       └── integration.test.js  # Integration tests for the application
├── package.json                 # npm configuration file
├── terraform.tfvars             # Variable values for Terraform
├── .gitignore                   # Files to be ignored by Git
└── README.md                    # Project documentation
```

## Setup Instructions

1. **Clone the repository:**
   ```
   git clone <repository-url>
   cd aws-nodejs-project
   ```

2. **Install dependencies:**
   ```
   npm install
   ```

3. **Configure AWS credentials:**
   Ensure that your AWS credentials are configured in your environment. You can set them up using the AWS CLI or by creating a `~/.aws/credentials` file.

4. **Deploy the infrastructure:**
   Navigate to the `infrastructure` directory and run:
   ```
   terraform init
   terraform apply
   ```

5. **Test the API:**
   Once the infrastructure is deployed, you can test the API Gateway endpoint using tools like Postman or curl. Send a POST request with a JSON body containing the `nombre` parameter.

## Architecture Overview

- **API Gateway:** Exposes the HTTP endpoint for the application.
- **ECS:** Hosts the Node.js application that handles incoming requests.
- **SQS:** Receives messages from the API Gateway.
- **Lambda:** Processes messages from the SQS queue and interacts with S3.
- **S3:** Stores files created by the Lambda function.
- **CloudWatch:** Logs the process for monitoring and debugging.

## Running Tests

To run the unit and integration tests, use the following command:
```
npm test
```

## License

This project is licensed under the MIT License.