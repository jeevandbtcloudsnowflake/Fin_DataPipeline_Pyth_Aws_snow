
# -----------------------------------------------------------------------------
# Terraform Resource Syntax Example:
# resource "<provider>_<type>" "<name>" {
#   <argument1> = <value1>
#   <argument2> = <value2>
#   ...
# }
# -----------------------------------------------------------------------------

# Provider configuration: Specifies AWS as the cloud provider and region.
provider "aws" {
  region = "ap-south-1"
}


# S3 Bucket: Stores raw financial transaction data. Private access only.
resource "aws_s3_bucket" "raw_data" {
  bucket = "pythawssnow-financial-transactions-raw"
}


# IAM Role for Lambda: Allows AWS Lambda service to assume this role.
resource "aws_iam_role" "lambda_role" {
  name = "lambda_basic_execution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}


# IAM Policy Attachment: Grants Lambda basic execution permissions (CloudWatch logging).
resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


# IAM Inline Policy: Allows Lambda to read/write/list objects in the S3 bucket.
resource "aws_iam_role_policy" "lambda_s3_access" {
  name = "lambda_s3_access"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.raw_data.arn,
          "${aws_s3_bucket.raw_data.arn}/*"
        ]
      }
    ]
  })
}


# Lambda Function: Processes data from S3. Uses Python 3.9 runtime and IAM role above.
resource "aws_lambda_function" "sample_lambda" {
  function_name = "sampleDataIngest"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  filename      = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")
}


# Output: Displays the name of the created S3 bucket after deployment.
output "s3_bucket_name" {
  value = aws_s3_bucket.raw_data.bucket
}
