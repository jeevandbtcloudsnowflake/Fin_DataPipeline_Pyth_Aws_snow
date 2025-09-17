# AWS Data Pipeline for Financial Transactions - Project Summary

## 1. Structured Approach
- **Understand Requirements:** Clarified business goals, data sources, outputs, and compliance needs.
- **Design Architecture:** Planned AWS resources (S3, Lambda, IAM), ETL logic in Python, and integration with Snowflake.
- **Infrastructure as Code (IaC):** Decided to use Terraform for provisioning AWS resources.
- **Proof-of-Concept (POC):** Started with a minimal workflow to validate the approach and reduce risk.

## 2. Initial Setup
- Created a new project directory: `e:/Jeevan/Python-AWS-Snow`.
- Added a Terraform configuration file (`main.tf`) to define AWS resources:
  - S3 bucket for raw data storage
  - IAM role and policies for Lambda
  - Lambda function resource
- Added a sample Python Lambda handler (`lambda_function.py`).
- Zipped the handler as `lambda_function.zip` for deployment.

## 3. AWS Account Configuration
- Created an IAM user for secure access (instead of using the root account).
- Generated Access Key ID and Secret Access Key for the IAM user.
- Configured AWS CLI locally using `aws configure`.

## 4. Terraform Initialization & Deployment
- Ran `terraform init` to initialize the project.
- Ran `terraform plan` and `terraform apply` to provision resources.

## 5. Issues/Errors Encountered & Fixes
### a. S3 Bucket ACL Deprecation
- **Issue:** Terraform warning: `acl = "private"` is deprecated.
- **Fix:** Removed the `acl` line from the S3 bucket resource.

### b. S3 Bucket Name Conflict
- **Issue:** Error: `BucketAlreadyExists`. S3 bucket names are globally unique.
- **Fix:** Changed the bucket name to a unique value (e.g., `financial-transactions-raw-jeevan-20250916`).

### c. Lambda Deployment Package
- **Issue:** AWS Lambda requires code to be uploaded as a ZIP file.
- **Fix:** Zipped `lambda_function.py` as `lambda_function.zip` before running Terraform.

## 6. Current Status
- All resources have been successfully provisioned using Terraform.
- The infrastructure is ready for further development (data ingestion, ETL logic, integration with Snowflake).

## 7. Next Steps
- Develop and test the Lambda function for data ingestion and processing.
- Set up Snowflake integration for processed data.
- Expand the pipeline as needed for business requirements.

---

**This document summarizes the project setup, approach, encountered issues, and their resolutions. It serves as a reference for future development and onboarding.**
