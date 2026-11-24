# Three-tier app on AWS with Terraform and Kubernetes

Based on a course project (AmanPathak-DevOps, End-to-End Kubernetes Three-Tier DevSecOps Project). I use it to practise Terraform, Jenkins pipelines and Kubernetes manifests.

- `Application-Code/`: Node.js backend (port 3500) and React frontend, each with a Dockerfile.
- `Jenkins-Server-TF/`: Terraform for a Jenkins server on AWS (VPC, subnet, internet gateway, route table, security group, EC2 instance, IAM role).
- `Jenkins-Pipeline-Code/`: Jenkinsfiles for backend and frontend (SonarQube, OWASP Dependency-Check, Trivy, Docker build, push to Amazon ECR).
- `Kubernetes-Manifests-file/`: manifests for frontend, backend, MongoDB (persistent volume) and ingress.

## Checked locally

`terraform init -backend=false` and `terraform validate` pass; the manifests parse; the backend starts and the frontend builds. I have not deployed this stack.

## Change before you use it

These values belong to the course author's setup:

- `Jenkins-Server-TF/backend.tf`: your own S3 bucket and DynamoDB lock table.
- `Jenkins-Server-TF/variables.tfvars`: your own EC2 key pair name.
- `Kubernetes-Manifests-file/*/deployment.yaml`: image URIs from your own ECR account.
- `Kubernetes-Manifests-file/ingress.yaml`: your own host name.
- Jenkinsfiles: the repository URL.

## Security notes

- The Jenkins role has the ECR power-user policy only (it was AdministratorAccess). Create the EKS cluster with `eksctl` from a separate admin identity.
- Database credentials are not stored in git. Create the secret with the command in `Kubernetes-Manifests-file/Database/secrets.example.yaml`. An earlier commit contained a demo secret (base64 `admin` / `password123`); never reuse it anywhere.
- The Dockerfiles use `node:14`, which is end of life. Moving to a current LTS image is a to-do.
