resource "aws_s3_bucket" "files_bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"

  tags = {
    Name        = var.s3_bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.files_bucket.id

  versioning {
    enabled = true
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.files_bucket.bucket
}