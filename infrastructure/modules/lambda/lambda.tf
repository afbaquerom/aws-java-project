resource "aws_lambda_function" "sqs_processor" {
  function_name = "sqsProcessor"
  handler       = "handlers/lambdaHandler.lambdaHandler"
  runtime       = "nodejs14.x"
  role          = aws_iam_role.lambda_exec.arn
  source_code_hash = filebase64sha256("path/to/your/deployment/package.zip")

  environment {
    S3_BUCKET = aws_s3_bucket.file_storage.bucket
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_policy]
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_exec.name
}

resource "aws_lambda_event_source_mapping" "sqs_event" {
  event_source_arn = aws_sqs_queue.my_queue.arn
  function_name    = aws_lambda_function.sqs_processor.arn
  enabled          = true
}