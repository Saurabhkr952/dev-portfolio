# dev-portfolio 
This web-application is designed/created by [Adrian Hajdin](https://github.com/adrianhajdin).


<img width="720" alt="vlc_KSWDFf6SkR" src="https://user-images.githubusercontent.com/32189783/226804882-d66ba1ab-7c80-424a-b6fd-bd0d1abb9de9.png">


# This diagram represents a continuous integration and delivery (CI/CD) pipeline for this project.

## TechStack Used:
<p align="left">➡️ Git
<p align="left">➡️ Github Actions 
<p align="left">➡️ Docker
<p align="left">➡️ Kubernetes
<p align="left">➡️ Argo CD





![cicd github actions project diagram](https://user-images.githubusercontent.com/32189783/226803395-6f7d3c2c-e72e-48aa-aa2f-f1f8f5bf74a4.jpg)

  
Here are the steps how it works:
1. Developers push the code to the Github repository.
2. Github Actions automatically starts a workflow when new  code is pushed to the repository.
3. The workflow starts by checking out the code and building the Docker image for the React application.
4. After the Docker image is built, Github Actions pushes the image to DockerHub.
5. Github Actions then updates the Kubernetes manifests stored in the Git repository with the new Docker image tag.
6. ArgoCD continuously monitors the Git repository for changes and updates the Kubernetes objects accordingly.
7. Once ArgoCD detects the changes, it deploys the updated application to the Kubernetes cluster.
  
  
  Kubernetes Manifest Repository: https://github.com/Saurabhkr952/dev-portfolio-manifest
  
