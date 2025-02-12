# AWS and GitHub CI/CD Project

This project integrates AWS services with GitHub for continuous integration and continuous deployment (CI/CD) using Terraform. The infrastructure includes an API Gateway, ECS service, SQS queue, Lambda function, S3 bucket, and CloudWatch log group.

## Project Structure

```
aws-github-cicd-project
├── terraform
│   ├── main.tf          # Main Terraform configuration file
│   ├── variables.tf     # Input variables for Terraform
│   ├── outputs.tf       # Output values from Terraform
│   └── provider.tf      # AWS provider configuration
├── .github
│   └── workflows
│       ├── plan.yml     # GitHub Actions workflow for Terraform plan
│       └── apply.yml    # GitHub Actions workflow for Terraform apply
├── .gitignore            # Files and directories to ignore by Git
└── README.md             # Project documentation
```

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd aws-github-cicd-project
   ```

2. **Configure AWS Credentials**
   Ensure that your AWS credentials are set up in your environment. You can do this by exporting the following environment variables:
   ```bash
   export AWS_ACCESS_KEY_ID=<your-access-key>
   export AWS_SECRET_ACCESS_KEY=<your-secret-key>
   ```

3. **Modify Variables**
   Update the `terraform/variables.tf` file with your desired configuration, including the AWS region and resource names.

4. **GitHub Actions Workflows**
   The project includes two GitHub Actions workflows:
   - **Plan Workflow**: Automatically runs `terraform plan` to preview changes.
   - **Apply Workflow**: Automatically runs `terraform apply` to create or update the infrastructure.

## Usage

- To trigger the workflows, push changes to the main branch or create a pull request. The workflows will automatically execute based on the defined triggers in the `.github/workflows` directory.

## Additional Information

For more details on how to use Terraform with AWS, refer to the [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs).