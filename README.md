# Building a Scalable and Secure Next.js Portfolio Website on AWS Using Terraform

## 1 Overview
This project is part of my ongoing cloud computing course, where I implemented a real-world scenario by deploying a Next.js portfolio website, using AWS services and Infrastructure as Code (IaC) with Terraform. 

The project demonstrates my ability to set up and manage cloud infrastructure, ensuring high availability, scalability, and cost-effectiveness.

<br>

## 2 Architecture Diagram

The architectural design for this project is illustrated in the following diagram.

![2024-09-03_00h11_20](https://github.com/user-attachments/assets/c44bcee5-1a71-455b-9dc8-c596b0aea2be)


- **Next.js Application:** The frontend application is built using Next.js, a popular React framework.
- **S3 Bucket:** The static assets of the Next.js application are stored in an Amazon S3 bucket, which serves as the origin for the website.
- **CloudFront (CDN):** Although not shown in this simplified diagram, CloudFront is used to deliver the content globally, ensuring fast and reliable access for users.
- **Terraform:** The entire infrastructure is provisioned using Terraform, allowing for automated and repeatable deployments.

<br>

## 3 Terraform Configuration

### 3.1 main.tf
The [main.tf](hasans-blog/terraform-js/main.tf) file is the core of the Terraform configuration. It defines the AWS resources required for this project, including:

- **S3 Bucket:** Where the static assets of the Next.js application are stored.

- **CloudFront Distribution:** Serves the content globally, ensuring low latency and high transfer speeds.

- **S3 Bucket Policy and Access Controls:** Ensures that the bucket is accessible by CloudFront but remains secure against unauthorized access.

This file is located in the terraform-nextjs directory, which was specifically created to contain all Terraform configurations for this project.

<br>

### 3.2 state.tf
The [state.tf](hasans-blog/terraform-js/state.tf) file configures the backend for storing the Terraform state. It uses an S3 bucket and DynamoDB for state locking and consistency, ensuring that multiple users do not overwrite each other's changes.

Before using this configuration, you need to manually create an S3 bucket and a DynamoDB table in AWS:

- **S3 Bucket:** Create a new S3 bucket to store the Terraform state file. Make sure the bucket name is unique globally.

- **DynamoDB Table:** Create a new DynamoDB table with a primary key named LockID. This table will be used for state locking to prevent concurrent modifications.

Once these resources are created, update the state.tf file with the correct bucket name and DynamoDB table name:

bash
```
terraform {
  backend "s3" {
    bucket         = "your-unique-s3-bucket-name"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-central-1"   # Adjust to your region
    dynamodb_table = "your-dynamodb-table-name"
  }
}
```

<br>

## 4 Project Components

### 4.1 Next.js Application

The frontend application has been created using the Next.js framework, which provides two key features: server-side rendering and static site generation.
The application is developed on a local machine and then built to generate static assets that are ready for deployment.

<br>

### 4.2 AWS S3 Bucket

An S3 bucket is employed for the storage of the static assets associated with the Next.js application.
The bucket is configured with the requisite permissions to permit CloudFront to retrieve and serve the content.

<br>

### 4.3 AWS CloudFront
CloudFront is employed as a content delivery network (CDN) to facilitate the global distribution of static assets.
This ensures that the content is delivered with minimal latency and high transfer speeds.

### 4.4 Terraform Configuration
The entire infrastructure, including the S3 bucket and CloudFront distribution, is provisioned using Terraform.
The use of Terraform scripts facilitates the automation of the setup process, thereby enhancing the efficiency and reproducibility of the deployment procedure.

<br>

## 5 Usage

### 5.1 Prepare the Next.js Application

- Clone the repository and navigate to the project directory.
- Install the required dependencies and build the Next.js application:

bash 
```
npm install
npm run build
```

The build process generates an out folder containing the static assets.

<br>

### 5.2. Deploy the Infrastructure using Terraform
Navigate to the Terraform configuration directory:

bash
```
cd terraform-nextjs
```

- Initialize Terraform and apply the configuration:
bash
```
terraform init
terraform plan
terraform apply
```
<br>

### 5.3 Upload the Static Assets to S3
Sync the out folder to the S3 bucket:
bash
```
aws s3 sync ../blog/out s3://your-s3-bucket-name
```

<br>

### 5.4 Access the Deployed Website
Obtain the CloudFront URL:
bash
```
terraform output cloudfront_url
```
Open the CloudFront URL in your browser to view the deployed Next.js portfolio site.

<br>

### 5.5 Steps to Destroy
To clean up all resources created by this project, run:

bash
```
terraform destroy
```

<br>

## 6 Conclusion

This project showcases my ability to deploy a secure, scalable, and globally accessible web application on AWS using Terraform. 

By leveraging S3 for storage, CloudFront for content delivery, and Terraform for IaC, I’ve demonstrated a comprehensive understanding of AWS services and best practices for cloud deployment.






