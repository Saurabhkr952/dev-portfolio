# Terraform Alpine Docker Image

This contains Alpine Linux-based image with 
- zsh shell
- Terraform 
- AWS CLI 
- kubectl
- Git

## Run the container with the current file system with User's Home Directory attached(contains aws configurations) 
### The container can access AWS configurations stored in the user's Home Directory

```bash 
docker run -it -v ${PWD}:/work -w /work -v ${HOME}:/root/ saurabhkr952/dev-tools-alpine --net host
```
