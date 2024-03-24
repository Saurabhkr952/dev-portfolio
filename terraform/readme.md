# Terraform Infrastructure Deployment

This repository contains Terraform configuration files to deploy an infrastructure environment on a cloud platform AWS. The configuration files are organized as follows:

- [vpc.tf](vpc.tf): Creates a Virtual Private Cloud (VPC) in the cloud environment.

- [eks-cluster.tf](eks-cluster.tf): Sets up an Amazon EKS (Elastic Kubernetes Service) cluster for container orchestration.

- [main.tf](main.tf): Main Terraform configuration for creating AWS resources. It specifies the AWS region as `ap-south-1` and necessary providers for `kubectl` and `helm`.

- [output.tf](output.tf): Defines output values shown after deployment. Outputs include EKS cluster details like endpoint, security group IDs, and name.

- [terraform.tfvars](terraform.tfvars): Customize variables in this file to tailor the Terraform configuration to your environment. Variables enhance flexibility and adaptability.

## Prerequisites

Before using these Terraform configurations, make sure you have:

- An active cloud account (e.g., AWS) with appropriate permissions.
- AWS CLI installed and configured with your AWS access key ID and secret access key.
- Helm installed on your machine. Helm is required for installing the nginx-ingress-controller.
- Terraform installed on your machine. Get it from [Terraform's official website](https://www.terraform.io/downloads.html).


## Note: Running this on Windows using Powershell/Command Prompt may lead to errors.

For a smoother experience, consider the following alternatives:
- Utilize a Linux EC2 instance if available.
- Use Windows Subsystem for Linux (WSL) to run Linux commands seamlessly on your Windows system.
- Run a Docker container (Alpine or Ubuntu) and install the required packages within the container environment. Best Way[Link](https://github.com/Saurabhkr952/dev-portfolio/blob/main/terraform/dev-tools-alpine.md)

## How to Deploy

To deploy the infrastructure using Terraform, follow these steps:

1. Clone this repository to your local machine.
2. Navigate to the directory containing the Terraform configuration files.
3. Open a terminal in this directory.
4. Initialize Terraform by running the command:
    ```
    terraform init
    ```
5. Once initialization is complete, apply the Terraform configuration by running:
    ```
    terraform apply --auto-approve
    ```
The `--auto-approve` flag automatically approves and applies the changes without requiring manual confirmation.

After the deployment process completes, Terraform will display the output values defined in `output.tf`, providing information about the deployed infrastructure.

## Grab the eks config
```
aws eks update-kubeconfig --name myapp-eks-cluster --region ap-south-1
```

## Install Nginx-Ingress Controller 

#### Don't get confused between "Ingress" and "Ingress Controller"

When installing the NGINX Ingress Controller, keep in mind that there are three versions available:

1. Kubernetes Community version: This version is maintained by the Kubernetes community and can be found at [kubernetes/ingress-nginx on GitHub](https://github.com/kubernetes/ingress-nginx).

2. NGINX Open Source version: This version is based on NGINX Open Source and is available at [nginxinc/kubernetes-ingress on GitHub](https://github.com/nginxinc/kubernetes-ingress).

3. NGINX Plus version: This is a commercial product based on NGINX Plus, offering additional features and support.  


#### We are using Kubernetes community version here
Run the following command, to install the NGINX Ingress Controller:

 
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/cloud/deploy.yaml
```


## How to Delete the Infrastructure

To delete the infrastructure created by Terraform and uninstall the NGINX Ingress Controller, follow these steps:

1. First, delete the NGINX Ingress Controller by running the command:
    ```bash
    kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/cloud/deploy.yaml
    ```

2. After deleting the NGINX Ingress Controller, you can destroy the Terraform-managed infrastructure by running the command:
    ```bash
    terraform destroy --auto-approve
    ```
