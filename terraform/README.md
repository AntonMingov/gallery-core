# Terraform

Deploy gallery-core on AWS EC2.

## Setup

Copy `terraform.tfvars.example` to `terraform.tfvars` and fill in your values:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` - at minimum set `key_pair_name`.

Then:

```bash
terraform init
terraform plan
terraform apply
```

## After deploy

SSH into the instance (use the output from `terraform apply`):

```bash
ssh -i ~/.ssh/your-key.pem ubuntu@<public_ip>
```

Docker is pre-installed. Build and run your containers manually.

## Cleanup

```bash
terraform destroy
```
