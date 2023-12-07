# Cross-Project Cloud SQL Connection with Private Service Connect and Terraform

## Introduction

This repository contains Terraform scripts that set up Cloud SQL (MySQL) instance in Project A, and networking components, Private Service Components, and a test instance in Project B.

## Prerequisites

Prerequisites:
- Terraform (~> 5.7.0)
- gcloud
- Two GCP projects created beforehand

## Running

1. Add a `terraform.tfvars` file and provide necessary values for variables.
x
2. Login to gcloud with your Google Cloud user.

```bash
gcloud auth login
gcloud auth application-default login
```

3. Initialize, plan, and apply Terraform scripts.

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

4. Retrieve MySQL test user password.

Post-Terraform execution, utilize the provided Bash command to securely retrieve the MySQL test password from the output:

```bash
terraform output -raw mysql_test_password
```

Copy the password for later use after this step.

5. Verify connection on the test instance.

SSH into the test instance in Project B using the command below. Replace the ZONE and PROJECT_B_ID.

```bash
gcloud compute ssh "prj-b-test-vm" \
  --zone ZONE \
  --project PROJECT_B_ID \
  --tunnel-through-iap
```

Then connect to the MySQL instance using the command below.

```bash
mysql --host 10.200.0.240 --user test -p
```
