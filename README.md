# AWS Java Project

This project is a complete AWS-based application built using Java. It integrates various AWS services including ECS, API Gateway, SQS, Lambda, and S3, along with unit testing and CI/CD using GitHub Actions.

## Project Structure

```
aws-java-project
├── src
│   ├── main
│   │   ├── java
│   │   │   └── com
│   │   │       └── example
│   │   │           └── App.java
│   │   └── resources
│   ├── test
│       ├── java
│       │   └── com
│       │       └── example
│       │           └── AppTest.java
│       └── resources
├── infrastructure
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── provider.tf
├── .github
│   └── workflows
│       └── ci.yml
├── build.gradle
├── settings.gradle
├── README.md
└── .gitignore
```

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/aws-java-project.git
   cd aws-java-project
   ```

2. **Configure AWS Credentials**
   Ensure that your AWS credentials are configured in your environment. You can set them up using the AWS CLI:
   ```bash
   aws configure
   ```

3. **Deploy Infrastructure**
   Navigate to the `infrastructure` directory and run the following commands to deploy the AWS infrastructure using Terraform:
   ```bash
   cd infrastructure
   terraform init
   terraform apply
   ```

4. **Build the Java Application**
   Use Gradle to build the application:
   ```bash
   cd ..
   ./gradlew build
   ```

5. **Run Unit Tests**
   To ensure everything is working correctly, run the unit tests:
   ```bash
   ./gradlew test
   ```

## Usage

Once the infrastructure is deployed, you can interact with the API Gateway endpoint to send requests. The endpoint will accept a parameter called `nombre`, which will be processed by the application.

## Deployment

The application is set up for continuous integration using GitHub Actions. The workflow defined in `.github/workflows/ci.yml` will automatically build and test the application on each push to the repository.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.