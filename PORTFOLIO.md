# Terraform OCI DevOps Infrastructure

## Project Overview

Designed and automated a cloud infrastructure project on Oracle Cloud Infrastructure (OCI) using Terraform and GitHub Actions.

The project demonstrates a complete Infrastructure as Code workflow with isolated DEV and PROD environments, reusable Terraform modules, remote state management, automated CI checks, controlled deployments, and Linux server provisioning.

## What I Implemented

- Built reusable Terraform modules for networking and compute resources
- Created separate DEV and PROD environments
- Provisioned OCI VCNs, public subnets, Internet Gateways, route tables and security lists
- Provisioned Ubuntu compute instances using Terraform
- Configured separate remote Terraform state for DEV and PROD using OCI Object Storage
- Created GitHub Actions CI pipelines for Terraform format, validation and plan
- Created manual deployment workflows for DEV and PROD
- Added manual approval protection for PROD deployments
- Automated Ubuntu server configuration with cloud-init
- Automatically installed and started Nginx after VM creation
- Created a controlled DEV compute destroy workflow
- Tested the complete DEV lifecycle: provision → verify → destroy compute → restore → verify

## CI/CD Workflow

Push to main:

`Terraform fmt → Validate DEV/PROD → Plan DEV/PROD`

DEV deployment:

`Manual workflow → Terraform Plan → Terraform Apply`

PROD deployment:

`Manual workflow → Approval → Terraform Plan → Terraform Apply`

DEV compute lifecycle:

`Apply → Verify → Destroy Compute → Plan → Apply → Verify`

## Verification

The deployed infrastructure was verified by:

- Successful Terraform plans and applies
- Successful GitHub Actions CI runs
- Terraform remote state verification
- SSH access to provisioned Ubuntu instances
- Successful cloud-init completion
- Nginx running as a systemd service
- HTTP response from the deployed Nginx server
- Successful destruction and recreation of the DEV compute instance

## Technologies

Terraform · Oracle Cloud Infrastructure (OCI) · GitHub Actions · Linux · Ubuntu · Nginx · cloud-init · Git · SSH

## Repository

GitHub: https://github.com/surikkarol-alt/terraform-learning
