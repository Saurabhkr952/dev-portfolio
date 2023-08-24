# Project Documentation: Dev Portfolio

This README provides a comprehensive guide on setting up the **Dev Portfolio** project, showcasing robust **DevOps** practices. The project involves provisioning an **AWS EKS** cluster using **Terraform**, implementing a **CI/CD pipeline** with **GitHub Actions**, **Docker**, **Kubernetes**, and **Argo CD**, and ensuring security best practices are followed.

## Table of Contents
- [Overview](#overview)
- [Continuous Integration and Delivery (CI/CD) Pipeline](#continuous-integration-and-delivery-cicd-pipeline)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
   - [Provision AWS EKS Cluster](#provision-aws-eks-cluster)
   - [Configure GitHub Actions Workflow](#configure-github-actions-workflow)
   - [Add Secrets](#add-secrets)
   - [Install Argo CD on EKS](#install-argo-cd-on-eks)
- [Workflow Steps](#workflow-steps)
- [Conclusion](#conclusion)

## Overview

The **Dev Portfolio** project focuses on creating a portfolio website. This README guides you through setting up the project's infrastructure, implementing a **robust CI/CD pipeline**, and ensuring **security measures** are in place.

[Adrian Hajdin](https://github.com/adrianhajdin) 


## Continuous Integration and Delivery (CI/CD) Pipeline

The diagram below illustrates the **CI/CD pipeline** used in this project:

![CI/CD Pipeline Diagram](https://user-images.githubusercontent.com/32189783/226803395-6f7d3c2c-e72e-48aa-aa2f-f1f8f5bf74a4.jpg)

## Prerequisites

Before you begin, ensure you have the following:

- **AWS account**
- **Terraform** installed
- **Docker Hub account**
- **GitHub account**
- **Slack account** (for notifications)

## Setup Instructions

### Provision AWS EKS Cluster (work in progress)

1. Clone the project repository: `git clone https://github.com/Saurabhkr952/dev-portfolio.git`
2. Navigate to the `terraform` directory: `cd dev-portfolio/terraform`
3. Modify the Terraform configuration files to match your environment.
4. Run `terraform init` and `terraform apply` to provision the **EKS cluster**.


### Configure GitHub Actions Workflow

To set up the workflow, follow these steps and modify the appropriate lines in the provided workflow file (`./.github/workflows/multi-stage-workflow.yml`):

1. **Build and Push Docker Image Job:**
   Navigate to the `build` job section and make the following changes:
   - **Line 17:** Replace `saurabhkr952/dev-portfolio` with your desired image name.

2. **Container Vulnerability Check Job:**
   Navigate to the `scan_upload` job section and make the following change:
   - **Line 29:** Replace `'docker.io/saurabhkr952/gdev-portfolio'` with your image name.

3. **Update Manifest Job:**
   Navigate to the `update_manifest` job section and make the following changes:
   - **Line 62:** Replace `saurabhkr952/dev-portfolio-manifest` with your manifest repository name.
   - **Line 42:** Replace `saurabhkr952/dev-portfolio` with the appropriate image reference.
   - **Line 67:** Replace `saurabhkr952@gmail.com` with your GitHub Gmail.
   - **Line 68:** Replace `saurabhkr952` with your GitHub username.
   - **Line 70:** Replace `saurabhkr952/dev-portfolio` with your docker image at both place.
                  & also replace `deployment.yaml` with filename.yaml with path.
   - **Line 77:** Replace `saurabhkr952/dev-portfolio-manifest` with your manifest repository. name.   
               

4. **Slack Workflow Status Job:**
   Navigate to the `slack-workflow-status` job section and make the following changes:
   - **Line 96:** Replace `#general` with your channel name.


## Add Secrets

To add the necessary secrets, follow these steps:
1. Go to the repository settings.
2. Under the security settings, access the 'Secrets and Variables' section.
3. Inside the 'Secrets and Variables' section, proceed to the 'Actions' subsection.
4. Add the following repository secrets:
   - `DOCKERHUB_USERNAME`: Your DockerHub username.
   - `DOCKERHUB_TOKEN`: Your DockerHub password.
   - `PAT_TOKEN`: Your GitHub Personal Access Token.
   - `SLACK_WEBHOOK_URL`: Your Slack webhook URL.    Refer to this [guide](https://devopseasyinitiate.hashnode.dev/how-to-get-slack-webhook-url) on how to obtain the URL.
     
### Install Argo CD on EKS

Refer to the [official Argo CD documentation](https://argo-cd.readthedocs.io/en/stable/getting_started/) to install Argo CD on your **EKS cluster**.
  
## Workflow Steps

1. Developers push code to the GitHub repository.
2. GitHub Actions automatically triggers a workflow when new code is pushed.
3. The workflow starts by building the Docker image and then pushing it to DockerHub.
4. After the Docker image is successfully pushed, the workflow scans the container for vulnerabilities.
5. Following the vulnerability scan, the workflow updates the Kubernetes manifests in the Git repository with the new image tag.
6. **Argo CD** continuously monitors the Git repository for changes and updates the application version in the Kubernetes cluster.
7. Security vulnerabilities are reported and can be reviewed in the security tab.
8. Notifications are sent to **Slack** to provide information about the workflow status.
  
Kubernetes Manifest Repository: [dev-portfolio-manifest](https://github.com/Saurabhkr952/dev-portfolio-manifest)
  
