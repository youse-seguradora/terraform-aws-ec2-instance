# Basic EC2 instance

Configuration in this directory creates EC2 instances with different sets of arguments (with Elastic IP, with network interface attached, with credit specifications).

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ec2\_name | n/a | `any` | n/a | yes |
| vpc\_name | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ids | List of IDs of instances |
| instance\_id | EC2 instance ID |
| instance\_public\_dns | Public DNS name assigned to the EC2 instance |
| public\_dns | List of public DNS names assigned to the instances |
| tags | List of tags |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
