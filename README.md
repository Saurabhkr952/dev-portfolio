# Project Documentation: Dev Portfolio

This README provides a comprehensive guide on setting up the **Dev Portfolio** project, showcasing robust **DevOps** practices. The project involves provisioning an **AWS EKS** cluster using **Terraform**, implementing a **CI/CD pipeline** with **GitHub Actions**, **Docker**, **Kubernetes**, and **Argo CD**, and ensuring security best practices are followed.

## Table of Contents
- [Overview](#overview)
- [Setup Overview](#setup-overview)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
   - [Provision AWS EKS Cluster using Terraform](#provision-aws-eks-cluster)
     - [Scaling Ingress Controller in Kubernetes Cluster to Handle High Traffic](#scaling-ingress-controller-in-kubernetes-cluster-to-handle-high-traffic)
     - [Migrate from Traditional Auto-scaling group to Karpenter](#migrate-from-traditional-auto-scaling-group-to-karpenter)
     - [Secure Kubernetes API using rate Limiting](#secure-kubernetes-api-with-rate-limiting)
   - [Secure Kubernetes Cluster](#securing-kubernetes-cluster)
   - [Configure GitHub Actions Workflow](#configure-github-actions-workflow)
   - [Add Secrets](#add-secrets)
   - [Install Argo CD on EKS](#install-argo-cd-on-eks)
- [Workflow Steps](#workflow-steps)
- [Testing & Monitoring](#testing--monitoring)
  - [Load Testing](#load-testing)
  - [Monitor Nginx Ingress Controller](#monitor-nginx-ingress-controller) 
  - [Monitor Nodes Metrics]()
  - [Scaling Node using Karpenter]()
- [Cost Management](#cost-management)


## Overview

The **Dev Portfolio** project focuses on creating a portfolio website. This README guides you through setting up the project's infrastructure, implementing a **robust CI/CD pipeline**, and ensuring **security measures** are in place.

This website is Designed/Created by [Adrian Hajdin](https://github.com/adrianhajdin).

<img src="https://github.com/Saurabhkr952/dev-portfolio/assets/32189783/9b840485-5588-4e4d-92e5-742801a5a149" alt="dev-portfolio website" width="800" height="480" />

## Tech Stack

The **Dev Portfolio** project is built using a variety of tools and technologies to ensure robust development, deployment, and monitoring practices. Here's a list of the key technologies and tools used:

<div style="display: flex; align-items: center;">
    <img style="margin: 10px;" src="https://profilinator.rishav.dev/skills-assets/git-scm-icon.svg" alt="Git" height="60" />
    <img style="margin: 10px;" src="https://profilinator.rishav.dev/skills-assets/docker-original-wordmark.svg" alt="Docker" height="60" />
    <img style="margin: 10px;" src="https://aquasecurity.github.io/trivy/dev/imgs/logo.png" alt="Trivy Scanner" height="60" />
    <img style="margin: 10px;" src="https://seeklogo.com/images/G/github-actions-logo-031704BDC6-seeklogo.com.png" alt="Github Actions" height="60" />
    <img style="margin: 10px;" src="https://coralogix.com/wp-content/uploads/2021/06/Argo-CD-Version-Tags-1000X1000.png" alt="Argo CD" height="70" />
    <img style="margin: 10px;" src="https://profilinator.rishav.dev/skills-assets/terraformio-icon.svg" alt="Terraform" height="60" />
    <img style="margin: 10px;" src="https://www.sophos.com/sites/default/files/2022-02/aws-logo-white-orange.png" alt="AWS" height="60" />
    <img style="margin: 10px;" src="https://static-00.iconduck.com/assets.00/amazon-eks-icon-455x512-0zairb3r.png" alt="Amazon EKS" height="60" />
    <img style="margin: 10px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Prometheus_software_logo.svg/2066px-Prometheus_software_logo.svg.png" alt="Prometheus" height="60" />
    <img style="margin: 10px;" src="https://w7.pngwing.com/pngs/434/923/png-transparent-grafana-hd-logo.png" alt="Grafana" height="60" />
    <img style="margin: 10px;" src="https://ml.globenewswire.com/Resource/Download/67776224-155c-4a51-aa8d-d27d761b30ee" alt="Kubecost" height="60" />
</div>


This selection of tools and technologies collectively highlights a modern approach to DevOps practices, encompassing development, deployment, security, and monitoring.


## Setup Overview



https://github.com/Saurabhkr952/dev-portfolio/assets/32189783/95757ba9-be4e-4d4b-9fc1-7b48009a9819



## Prerequisites

Before you begin, ensure you have the following:

- **AWS account**
- **Terraform** installed
- **Docker Hub account**
- **GitHub account**
- **Slack account** (for notifications)

## Setup Instructions

### Provision AWS EKS Cluster 

1. Clone the project repository: `git clone https://github.com/Saurabhkr952/dev-portfolio.git`
2. Navigate to the `terraform` directory: `cd dev-portfolio/terraform`
3. Modify the Terraform configuration files to match your environment.
4. Run `terraform init` and `terraform apply` to provision the **EKS cluster**.

### Scaling Ingress Controller in Kubernetes Cluster to Handle High Traffic

Scaling Ingress Controller in Kubernetes Cluster to Handle High Traffic
When deploying your application in a Kubernetes cluster, having sufficient resources on your nodes is just part of the equation. During traffic spikes, your application can still experience latency issues or timeouts, impacting customer experience. This can happen even if your application pods are scaled properly. The ingress controller, which manages incoming traffic, can become a bottleneck.

To address this, we need to scale the ingress controller based on HTTP requests. As depicted in the diagram below, the left image shows a single ingress controller handling a large amount of traffic, which can lead to latency issues or timeouts for customers. On the right, multiple ingress controller pods handle the traffic more efficiently by scaling based on active requests.

<img src="/assets/scale-ingress-controller.png" alt="nginx-ingress-controller" width="800" height="480" />
 
#### Steps to scale the ingress controller 
1. Expose Nginx Ingress Controller Metrics: [Docs for installation](https://kdf) & [Expose Metrics using Service Monitors](https://kubernetes.github.io/ingress-nginx/user-guide/monitoring/)
2. Collect & store metrics using Prometheus: [Install Prometheus & Grafana using HELM chart]()
3. Use Autoscaler KEDA: [Docs for installation KEDA](https://keda.sh/docs/2.14/deploy/) & apply this manifest [KEDA ScaledObject manifest](https://github.com/Saurabhkr952/dev-portfolio-manifest/blob/main/keda.yaml) 
 
If you want to see how application performs under high traffic with scaling controllers check the `monitoring` section 

### Migrate from Traditional Auto-scaling group to Karpenter

Migrating to Karpenter offers `fast scaling` and `cost savings`. Its consolidation feature efficiently packs workloads onto nodes, minimizing resource waste and maximizing cost-effectiveness. It's a smart move for boosting scalability and optimizing expenses.

As I've already provisioned infrastructure using cluster auto-scaling groups, here's the [documentation](https://karpenter.sh/docs/getting-started/migrating-from-cas/) detailing the migration process to Karpenter.

Want to see how it scales. check the [Scaling Node using Karpenter](#scaling-node-using-karpenter) section.

### Secure Kubernetes API with Rate Limiting

Rate limiting within an NGINX Ingress Controller allows you to manage the flow of traffic or requests to your backend services within specific timeframes. This feature is crucial for preventing abuse, ensuring equitable usage, and safeguarding your services from potential overload due to excessive requests.

To implement rate limiting, follow the instructions provided in the [documentation](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#rate-limiting) by configuring annotations accordingly. These annotations define the rate limiting policies for your Kubernetes environment, ensuring a secure and stable API infrastructure.


## Securing Kubernetes Cluster

To ensure the security of the Kubernetes cluster for the **Dev Portfolio** project, the following measures have been implemented:

- [x] **Distroless Image Usage:** Utilized distroless images, containing only essential packages, to build Docker images, reducing vulnerability exposure.
- [x] **Container Runtime Security:** Ensured container runtime security by running containers as non-root users.
- [x] **Docker Image Signing:** Implemented Docker image signing using COSIGN to guarantee the integrity and authenticity of container images.
- [x] **Image Scanning:** Integrated Trivy into the CI/CD pipeline for thorough image and container scanning, enhancing security posture.
- [x] **Security Scanning:** Leveraged Kubescape for comprehensive security scanning based on NSA and MITRE guidelines.
- [x] **CIS Benchmark Adherence:** Adhered to Kubernetes CIS benchmarks for robust security standards and best practices.
- [x] **Secrets Management:** Safeguarded Kubernetes secrets using sealed secrets, ensuring encrypted and tamper-proof storage.
- [ ] **Network Policies:** Implemented network policies to restrict inter-pod communication at the OSI layer 3/4, fortifying the cluster's security posture. (Work in Progress)
- [ ] **RBAC Implementation:** Managed User & Permissions within Kubernetes using RBAC, ensuring granular control over access and actions. (Work in Progress)
- [ ] **mTLS Communication:** Established encrypted communication via mutual TLS (mTLS) between pods using service mesh technology, operating at the OSI layer 7, ensuring confidentiality and integrity of data in transit. (Not Implemented)
- [x] **etcd Security:** Secured the etcd data store, a critical component of Kubernetes, to safeguard cluster configuration and state. (As it is managed Kubernetes cluster so we don't need to worry about etcd. AWS takes responsibility for securing the control plane components, including etcd, as part of the managed service offering.)
- [ ] **Ingress Security:** Enhanced cluster security by securing ingress traffic using TLS encryption, mitigating the risk of eavesdropping and unauthorized access. (Work in Progress)


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
   - **Line 70:** Replace `saurabhkr952/dev-portfolio` with your docker image at both place, and also replace `deployment.yaml` with filename.yaml with path.
   - **Line 77:** Replace `saurabhkr952/dev-portfolio-manifest` with your manifest repository name.
4. **Slack Workflow Status Job:**
   Navigate to the `slack-workflow-status` job section and make the following changes:
   - **Line 96:** Replace `#general` with your channel name.

### Add Secrets

To add the necessary secrets, follow these steps:
1. Go to the repository settings.
2. Under the security settings, access the 'Secrets and Variables' section.
3. Inside the 'Secrets and Variables' section, proceed to the 'Actions' subsection.
4. Add the following repository secrets:
   - `DOCKERHUB_USERNAME`: Your DockerHub username.
   - `DOCKERHUB_TOKEN`: Your DockerHub password.
   - `PAT_TOKEN`: Your GitHub Personal Access Token.
   - `SLACK_WEBHOOK_URL`: Your Slack webhook URL. Refer to this [guide](https://devopseasyinitiate.hashnode.dev/how-to-get-slack-webhook-url) on how to obtain the URL.

### Install Argo CD on EKS

Refer to the [official Argo CD documentation](https://argo-cd.readthedocs.io/en/stable/getting_started/) to install Argo CD on your **EKS cluster**.

## Workflow Steps

Here's how the CI/CD pipeline works:

1. Developers push code to the GitHub repository.
2. GitHub Actions automatically triggers a workflow when new code is pushed.
3. The workflow starts by building the Docker image and then pushing it to DockerHub.  
4. After the Docker image is successfully pushed, the workflow scans the container for vulnerabilities.
5. Following the vulnerability scan, the workflow updates the Kubernetes manifests in the Git repository with the new image tag.
6. **Argo CD** continuously monitors the Git repository and updates the application version in the Kubernetes cluster.   
7. Security vulnerabilities are reported and can be reviewed in the security tab.
   ![Security Vulnerabilities](https://github.com/Saurabhkr952/dev-portfolio/assets/32189783/f0ce9f6d-ae90-48ef-9fad-82b3ef3e0e5e)   
8. After the workflow is successfully completed, the status is reflected as shown below:
   ![cicd pipeline status](https://github.com/Saurabhkr952/dev-portfolio/assets/32189783/1634442e-2d86-4593-8e03-ad0e1614a6af)    
9. Notifications are sent to **Slack** to provide information about the workflow status.
   ![Workflow Status](https://github.com/Saurabhkr952/dev-portfolio/assets/32189783/d4b5490c-b4d9-4607-a999-d371c7c0afc5)


## Testing & Monitoring
### Load Testing
Load testing is an essential aspect of ensuring the stability and performance of your Kubernetes cluster. We employ `k6s` for load testing, which allows us to simulate traffic and analyze how our system responds under high loads. By scripting test scenarios with k6s, we can assess the scalability and resilience of our Kubernetes setup.


#### Monitor Nginx Ingress Controller
To monitor the performance of our nginx-ingress-controller, we utilize Grafana dashboards.
![grafana-dashboard-1](/assets/1.5k-req-sec-1.png)
![grafana-dashboard-2](/assets/1.5k-req-sec-2.png)

NOTE: We have already set-up prometheus and grafana & exposing nginx ingress controller in [Scaling Ingress Controller in Kubernetes Cluster to Handle High Traffic](#scaling-ingress-controller-in-kubernetes-cluster-to-handle-high-traffic) section. 

### For monitoring and visualization, the following tools are utilized:

`Prometheus` and `Grafana`. Prometheus serves as the data source for Grafana, enabling the visualization of metrics and performance data. A Grafana dashboard is employed to monitor the Kubernetes cluster using data collected by Prometheus. 

Here's a preview of a Grafana dashboard monitoring the Kubernetes cluster:

![Grafana Dashboard](assets/grafana-dashboard.gif)
 

#### Scaling Node using Karpenter
![Scaling-Nodes](https://github.com/Saurabhkr952/dev-portfolio/assets/eks-karpenter) 


### Cost Management

Kubecost is used for Kubernetes cost allocation and resource management.

![Cost Management](https://github.com/Saurabhkr952/dev-portfolio/assets/32189783/0c25b53e-5c65-464f-834d-07654543a635)
  

## Kubernetes Manifest Repository: [dev-portfolio-manifest](https://github.com/Saurabhkr952/dev-portfolio-manifest)


## Work in Progress

**Note: This project is currently a work in progress. Certain sections are being actively developed and will be updated soon. The following enhancements are planned:**

- Detailed instructions on setting up Prometheus and Grafana for monitoring.
- A guide on setting up Kubecost for Kubernetes cost management.
