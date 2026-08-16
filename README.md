# Terraform OCI DevOps Project

Infrastructure as Code project built with Terraform and Oracle Cloud Infrastructure (OCI).

## Features

- Terraform modules for network and compute
- DEV and PROD environments
- Separate remote state for each environment
- OCI Object Storage backend
- GitHub Actions CI
- Terraform format and validation checks
- Automatic Terraform plan for DEV and PROD
- Manual Terraform apply for DEV
- Protected PROD apply with manual approval
- Cloud-init provisioning
- Nginx installation and startup

## Architecture

```text
                         GitHub
                           |
                    GitHub Actions
                           |
              +------------+------------+
              |                         |
             DEV                       PROD
              |                  Manual Approval
              |                         |
          Terraform                 Terraform
              |                         |
              +----------- OCI ---------+
                           |
              +------------+------------+
              |                         |
           DEV VCN                   PROD VCN
              |                         |
        Public Subnet              Public Subnet
              |                         |
         Ubuntu VM                  Ubuntu VM
              |                         |
           Nginx                      Nginx


                  OCI Object Storage
                     Remote State
                  +------+------+
                  |             |
              DEV State     PROD State
```

## Infrastructure

Each environment contains:

- VCN
- Public subnet
- Internet Gateway
- Route Table
- Security List
- OCI Compute Instance
- Ubuntu 24.04
- Nginx

## CI/CD

### CI

On every push to `main`:

1. `terraform fmt -check`
2. Terraform validation for DEV
3. Terraform validation for PROD
4. Terraform plan for DEV
5. Terraform plan for PROD

### CD

DEV deployment:

- Manual GitHub Actions workflow
- Terraform plan
- Terraform apply

PROD deployment:

- Manual GitHub Actions workflow
- GitHub Environment protection
- Manual approval
- Terraform plan
- Terraform apply

## Technologies

- Terraform
- Oracle Cloud Infrastructure
- GitHub Actions
- Ubuntu Linux
- Nginx
- Git

## Project Structure

```text
terraform-learning/
├── .github/
│   └── workflows/
│       ├── terraform-ci.yml
│       ├── terraform-apply-dev.yml
│       └── terraform-apply-prod.yml
│
└── lesson-09-environments/
    ├── modules/
    │   ├── network/
    │   └── compute/
    │
    └── environments/
        ├── dev/
        └── prod/

```

## Terraform Workflow

Terraform commands must be run from a specific environment directory.

For DEV:

```bash
cd lesson-09-environments/environments/dev
terraform init
terraform validate
terraform plan
```

For PROD:

```bash
cd lesson-09-environments/environments/prod
terraform init
terraform validate
terraform plan
```

Formatting for the whole repository can be checked from the repository root:

```bash
terraform fmt -check -recursive
```

## Provisioning

Terraform uses cloud-init during instance creation to automatically:

- Update package information
- Install Nginx
- Enable and start Nginx
- Create a test file confirming cloud-init execution

After deployment, connect to the created VM over SSH and verify:

```bash
cloud-init status
systemctl status nginx --no-pager
cat /var/tmp/cloud-init-test.txt
curl http://localhost
```

## Security

Sensitive data is not committed to the repository.

GitHub Actions Secrets are used for:

- OCI user OCID
- OCI tenancy OCID
- OCI API fingerprint
- OCI private API key
- OCI region
- SSH public key

PROD deployment is protected by a GitHub Environment and requires manual approval before `terraform apply`.
