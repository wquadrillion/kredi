## Deploying a Node.js Application to EKS with Terraform & Helm (CI/CD)

This project demonstrates a complete workflow for deploying a Node.js application to an Amazon Elastic Kubernetes Service (EKS) cluster using Terraform for infrastructure provisioning and Helm for application packaging and deployment. It also leverages GitHub Actions to automate the deployment process (CI/CD).

**Target Audience:**

This guide is intended for developers and infrastructure engineers familiar with Node.js development, Terraform configuration, Helm charts, and basic AWS knowledge. 

**Project Structure:**

* `main.tf`: Terraform configuration file defining the EKS cluster and related resources.
* `outputs.tf`): Captures cluster and database endpoints after Terraform apply.
* `variables.tf`: Defines configurable variables for infrastructure (cluster name, instance type, etc.).
* `charts/my-app`: Helm chart directory containing application deployment files.
    * `Chart.yaml`: Helm chart metadata.
    * `README.md` (this file): Deployment documentation.
    * `templates`: Kubernetes resource templates (deployment, service).
    * `values.yaml`: Helm chart configuration values.
* `app.js`: Your Node.js application code.
* `Dockerfile` (optional): Builds a Docker image for your application (if containerized).
* `.github/workflows/deploy.yml` (optional): GitHub Actions workflow for automated deployment.

**Prerequisites:**

* An AWS account with IAM permissions to create EKS clusters and RDS instances (optional).
* Terraform installed and configured with the AWS provider.
* Helm installed and configured to interact with your EKS cluster.
* Docker installed and configured with a Docker Hub account (optional, if using containerized application).
* A GitHub repository to host your project code.

**Deployment Workflow:**

The deployment process can be divided into manual and automated steps:

**1. Manual Setup (Optional):**

   a. **Configure Terraform (Optional):**

      * Edit `variables.tf` to define desired values for cluster name, instance type, RDS details (if applicable).
      * Initialize Terraform: `terraform init`
      * Review the execution plan: `terraform plan`
      * Apply the Terraform configuration to provision resources (**Caution:** Creates infrastructure in your AWS account): `terraform apply`

   b. **Build and Push Docker Image (Optional):**

      * Ensure you have Node.js and npm installed.
      * Build the Docker image: `docker build -t your-username/my-app:latest .` (replace username)
      * Login to Docker Hub: `docker login` (if pushing to Docker Hub)
      * Push the image: `docker push your-username/my-app:latest` (if pushing to Docker Hub)


**Running the Application:**

   After successful deployment (manual or CI/CD), the application should be accessible through the service defined in the Helm chart (e.g., NodePort). Refer to the Terraform outputs or Kubernetes service details to determine the access point (IP address, port).

**Additional Notes:**

* This is a basic example. You can customize the Terraform configuration, Helm chart, and application code to suit your specific needs.
* Consider security best practices when deploying applications to production environments.
* Refer to the official documentation for Terraform, Helm, Kubernetes, AWS EKS, and GitHub Actions for advanced usage and configuration options.

**Further Resources:**

* Terraform: [https://www.terraform.io/](https://www.terraform.io/)
* Helm: [https://helm.sh/](https://helm.sh/)
* Kubernetes: [https://kubernetes.io/docs/home/](https://kubernetes.io/docs/home/)
* AWS EKS: [https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html)
* GitHub Actions: [https://docs.github.com/actions](https://docs.github.com/actions)

**Maintaining the Project:**

* Update the Terraform configuration, Helm chart, and application code as needed.
* Re-run `terraform apply