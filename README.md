# Digital Twin

## Goal

This project is an **AI digital twin**: a web app where visitors can chat with a model that answers questions about your background and experience. It pairs a **Next.js** frontend with a **Python (FastAPI)** backend intended to run on **AWS Lambda**, with optional integrations for managed AI (for example Amazon Bedrock) and fallbacks where configured.

It is structured as a **Week 2 capstone** style exercise: infrastructure-as-code, cloud deployment, and a minimal product surface (chat UI + API).

## Deployment approach

Deployments are **automated with GitHub Actions**, **declared with Terraform**, and **run on AWS**.

### GitHub Actions

- **Deploy** (`.github/workflows/deploy.yml`): runs on pushes to `main` and via **workflow dispatch** so you can choose **dev**, **test**, or **prod**. It checks out the repo, assumes an **IAM role over OIDC** (no long-lived AWS keys in the repo), sets up Python, Terraform, and Node, then runs **`scripts/deploy.sh`** for the selected environment.
- **Destroy** (`.github/workflows/destroy.yml`): manual workflow to tear down an environment after confirmation.

Repository **secrets** (for example `AWS_ROLE_ARN`, `AWS_ACCOUNT_ID`, `DEFAULT_AWS_REGION`, and optional `OPENROUTER_API_KEY` passed through as `TF_VAR_*`) supply credentials and Terraform variables the workflow must not hardcode.

### Terraform

- Configuration lives under **`terraform/`**. It defines AWS resources (for example Lambda, API Gateway, S3, CloudFront, IAM) for the Digital Twin stack.
- **Remote state** is stored in **S3** with **DynamoDB** for locking, matching the backend settings used by `deploy.sh` / `destroy.sh` (bucket and table names follow the `twin-terraform-*` convention for this project).
- **Workspaces** (or equivalent environment selection in scripts) separate **dev**, **test**, and **prod** state so each environment can be managed independently.

### AWS

- The running system is **serverless and static hosting on AWS**: API and compute on **Lambda**, assets and site delivery via **S3** and **CloudFront**, with supporting services as defined in Terraform.
- **First-time setup** (OIDC role for Actions, state bucket, lock table) is done in your AWS account outside the app workflow, then CI/CD applies and updates the stack from the repo.

For a full bootstrap and secret checklist, follow your course guide (for example Week 2 Day 5) for the exact order: remote state, GitHub OIDC role, secrets, then push and run **Deploy Digital Twin**.
