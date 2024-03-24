# Terraform Alpine Docker Image

This Dockerfile builds an Alpine Linux-based Docker image with 
- zsh shell
- Terraform 
- AWS CLI 
- kubectl

## Run the container with the current file system attached

```bash 
docker run -it -v ${PWD}:/work saurabhkr952/dev-tools-alpine
```
