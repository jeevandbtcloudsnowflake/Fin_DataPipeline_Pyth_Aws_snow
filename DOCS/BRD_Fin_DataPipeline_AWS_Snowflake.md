# Business Requirements Document (BRD)

## Project Title
Financial Data Pipeline: Python, AWS, Snowflake Integration

## Date
September 18, 2025

## 1. Project Overview
This project aims to build a robust, scalable, and secure data pipeline for ingesting, processing, and loading financial data from various sources into Snowflake using AWS services and Python. The solution will enable automated data flows, support analytics, and ensure compliance with industry standards.

## 2. Objectives
- Automate ingestion of financial data from multiple sources (APIs, files, etc.)
- Transform and validate data using Python-based Lambda functions
- Store raw and processed data in AWS S3
- Load curated data into Snowflake for analytics and reporting
- Ensure data security, integrity, and auditability
- Provide modular, extensible architecture for future enhancements

## 3. Scope & Deliverables
### In Scope
- AWS infrastructure provisioning (S3, Lambda, IAM, etc.)
- Python Lambda function for ETL
- Terraform for IaC (Infrastructure as Code)
- Snowflake integration
- Documentation and monitoring setup

### Out of Scope
- Frontend dashboards
- Real-time streaming (initial phase)
- Non-financial data sources

## 4. Data Model Details

### Source Data
The source data consists of transaction and account information, which will be mapped to Snowflake tables as follows:

### Snowflake Table Definitions


#### Fact_Transactions
```sql
CREATE TABLE Fact_Transactions (
    transaction_id VARCHAR(64) PRIMARY KEY,
    account_id VARCHAR(64),
    amount NUMBER(18,2),
    currency VARCHAR(10),
    transaction_date TIMESTAMP_NTZ,
    description VARCHAR(255),
    category VARCHAR(50),
    -- Audit Columns
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_NTZ,
    created_by VARCHAR(50),
    updated_by VARCHAR(50),
    FOREIGN KEY (account_id) REFERENCES Dim_Accounts(account_id)
);
```

#### Dim_Accounts
```sql
CREATE TABLE Dim_Accounts (
    account_id VARCHAR(64) PRIMARY KEY,
    account_type VARCHAR(50),
    owner_name VARCHAR(100),
    opened_date DATE,
    -- Audit Columns
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_NTZ,
    created_by VARCHAR(50),
    updated_by VARCHAR(50)
);
```

These definitions follow Snowflake best practices:
- Use of `VARCHAR` for string fields with appropriate length
- `NUMBER(18,2)` for monetary values
- `TIMESTAMP_NTZ` for datetime fields
- `DATE` for date-only fields
- Primary and foreign key constraints for referential integrity

## 5. Project Iterations & Deliverables


### Iteration 1: Infrastructure Setup
- Provision AWS resources (S3, Lambda, IAM)
- Set up Terraform scripts
- Deliverable: Working AWS infrastructure, Terraform state
- Status: _Completed_

### Iteration 2: Data Ingestion & ETL Lambda
- Develop Python Lambda for ingesting and transforming financial data
- Store raw and processed data in S3
- Deliverable: Lambda function, S3 buckets, sample data flow
- Status: _In Progress_

### Iteration 3: Snowflake Integration
- Configure Snowflake connection
- Develop data loading scripts from S3 to Snowflake
- Deliverable: Data loaded into Snowflake, schema setup
- Status: _Pending_

### Iteration 4: Monitoring, Logging, and Documentation
- Implement logging and error handling
- Set up monitoring (CloudWatch, Snowflake logs)
- Complete project documentation
- Deliverable: Monitoring dashboards, documentation
- Status: _Pending_

---

## 8. Project Status & Closure

As of September 23, 2025, the project is being paused. The following has been completed:
- AWS infrastructure provisioned and tracked with Terraform
- BRD finalized with Snowflake-compliant data model and audit columns
- Initial Lambda function and S3 setup

Further development will resume at a later date. All documentation and code are up to date in the repository.

## 6. Success Criteria
- All iterations completed and deliverables accepted
- Data pipeline runs automatically and reliably
- Data is available in Snowflake for analytics
- Security and compliance requirements met

## 7. Change Management
Any changes to requirements, scope, or deliverables will be documented and approved by stakeholders before implementation.

---

_This BRD will be updated as the project progresses. Each iteration will be marked complete upon delivery and acceptance._
