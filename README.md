# AWS Node.js Project

This project is a serverless application built on AWS that utilizes various services including API Gateway, SQS, Lambda, and S3. The application is designed to receive a parameter called "nombre" through an API Gateway, send it to an SQS queue, trigger a Lambda function that creates a file with the provided name in an S3 bucket, and log the process in CloudWatch.

## Project Structure

```
aws-nodejs-project
├── src
│   ├── index.js               # Entry point of the Node.js application
│   ├── handlers
│   │   └── lambdaHandler.js    # Lambda function handler for processing SQS messages
│   └── utils
│       └── sqsHelper.js        # Helper functions for SQS interactions
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
├── .github
│   └── workflows
│       └── ci-cd.yml          # CI/CD workflow for GitHub Actions
├── package.json                # npm configuration file
├── terraform.tfvars            # Variable values for Terraform
├── README.md                   # Project documentation
└── .gitignore                  # Files and directories to ignore by Git
```

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd aws-nodejs-project
   ```

2. **Install Dependencies**
   ```bash
   npm install
   ```

3. **Configure AWS Credentials**
   Ensure that your AWS credentials are configured in your environment. You can set them up using the AWS CLI or by creating a `~/.aws/credentials` file.

4. **Deploy Infrastructure**
   Navigate to the `infrastructure` directory and run the following commands to deploy the infrastructure using Terraform:
   ```bash
   cd infrastructure
   terraform init
   terraform apply
   ```

5. **Run Tests**
   To run the unit and integration tests, use the following command:
   ```bash
   npm test
   ```

## Usage

Once the infrastructure is deployed, you can send a request to the API Gateway with the "nombre" parameter. The application will process the request, send the parameter to the SQS queue, and the Lambda function will create a file in the S3 bucket.

## Logging

Logs for the Lambda function can be viewed in the AWS CloudWatch service. This will help you monitor the execution and troubleshoot any issues.

## CI/CD

The project includes a CI/CD pipeline defined in `.github/workflows/ci-cd.yml` that automates the testing and deployment process. Make sure to configure your GitHub repository settings to enable GitHub Actions.

## License

This project is licensed under the MIT License.