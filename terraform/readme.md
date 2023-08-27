# Terraform Infrastructure Deployment

This repository contains Terraform configuration files to deploy an infrastructure environment on a cloud platform. The configuration files are organized as follows:

- [vpc.tf](vpc.tf): Creates a Virtual Private Cloud (VPC) in the cloud environment.

- [eks-cluster.tf](eks-cluster.tf): Sets up an Amazon EKS (Elastic Kubernetes Service) cluster for container orchestration.

- [main.tf](main.tf): Main Terraform configuration for creating AWS resources. It specifies the AWS region as `ap-south-1` and necessary providers for `kubectl` and `helm`.

- [output.tf](output.tf): Defines output values shown after deployment. Outputs include EKS cluster details like endpoint, security group IDs, and name.

- [terraform.tfvars](terraform.tfvars): Customize variables in this file to tailor the Terraform configuration to your environment. Variables enhance flexibility and adaptability.

## Prerequisites

Before using these Terraform configurations, make sure you have:

- An active cloud account (e.g., AWS) with appropriate permissions.
- Terraform installed on your machine. Get it from [Terraform's official website](https://www.terraform.io/downloads.html).
