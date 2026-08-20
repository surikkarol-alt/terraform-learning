# Terraform & OCI Infrastructure Automation with CI/CD

## Project Description

Built an automated cloud infrastructure solution using Terraform, Oracle Cloud Infrastructure (OCI), and GitHub Actions.

The project uses Infrastructure as Code to provision and manage separate DEV and PROD environments with reusable Terraform modules and remote state management.

I implemented CI/CD pipelines that automatically validate and plan infrastructure changes, while deployments are performed through controlled manual GitHub Actions workflows. Production deployment requires manual approval for additional safety.

Ubuntu cloud servers are automatically provisioned and configured with cloud-init, including automatic Nginx installation and startup.

## What I Delivered

- Reusable Terraform modules for networking and compute
- Separate DEV and PROD cloud environments
- OCI VCN, subnet, Internet Gateway, routing and security configuration
- Ubuntu VM provisioning with Terraform
- Remote Terraform state using OCI Object Storage
- Automated Terraform fmt, validate and plan with GitHub Actions
- Manual Terraform deployment workflows
- Protected PROD deployment with manual approval
- Automated server configuration using cloud-init
- Automatic Nginx installation and startup
- Controlled DEV compute destroy workflow
- Tested infrastructure destroy and recovery lifecycle

## Result

Created a working end-to-end Infrastructure as Code workflow:

Terraform → OCI → Ubuntu → Nginx

with automated CI checks and controlled deployment through GitHub Actions.

The DEV environment was successfully tested through the complete lifecycle:

Provision → Verify → Destroy Compute → Restore → Verify

## Skills & Technologies

Terraform, Oracle Cloud Infrastructure (OCI), GitHub Actions, CI/CD, Infrastructure as Code (IaC), Linux, Ubuntu, Nginx, cloud-init, Git, SSH
