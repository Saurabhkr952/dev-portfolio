# dev-portfolio 
This website is designed/created by [Adrian Hajdin](https://github.com/adrianhajdin) 


<img width="720" alt="vlc_KSWDFf6SkR" src="https://user-images.githubusercontent.com/32189783/226804882-d66ba1ab-7c80-424a-b6fd-bd0d1abb9de9.png">


# This diagram represents a continuous integration and delivery (CI/CD) pipeline for this project.

## TechStack Used:
<p align="left">➡️ Git
<p align="left">➡️ Github Actions 
<p align="left">➡️ Docker
<p align="left">➡️ Kubernetes
<p align="left">➡️ Argo CD


![cicd github actions project diagram](https://user-images.githubusercontent.com/32189783/226803395-6f7d3c2c-e72e-48aa-aa2f-f1f8f5bf74a4.jpg)

## Workflow Configuration

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
   - **Line 95:** Replace `${{ secrets.SLACK_WEBHOOK_URL }}` with your SLACK WEBHOOK URL.
   - **Line 96:** Replace `#general` with your channel name.


  
Here are the steps how it works:
1. Developers push the code to the Github repository.
2. Github Actions automatically starts a workflow when new  code is pushed to the repository.
3. The workflow starts by checking out the code and building the Docker image for the React application.
4. After the Docker image is built, GitHub Actions pushes the image to DockerHub.
5. Github Actions then updates the Kubernetes manifests stored in the Git repository with the new Docker image tag.
6. ArgoCD continuously monitors the Git repository for changes and updates the Kubernetes objects accordingly.
7. Once ArgoCD detects the changes, it deploys the updated application to the Kubernetes cluster.
  
  
  Kubernetes Manifest Repository: https://github.com/Saurabhkr952/dev-portfolio-manifest
  
