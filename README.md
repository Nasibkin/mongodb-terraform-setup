# MongoDB Atlas Terraform Configuration

This Terraform configuration automates the creation and management of MongoDB Atlas resources, including:
- Projects
- Clusters
- Database Users (with both password and IAM authentication)
- Backup Snapshots
- Backup Schedules

## Prerequisites

1. Terraform: Ensure Terraform is installed. Download it from [here](https://www.terraform.io/downloads.html).
2. MongoDB Atlas API Keys: Generate API keys from the MongoDB Atlas UI under Access Management > API Keys.
3. AWS IAM Roles: If using IAM authentication, ensure the necessary IAM roles are created in AWS.

## Configuration

### Variables

The following variables are required:

| Variable Name               | Description                                                                 |
|-----------------------------|-----------------------------------------------------------------------------|
| `project_name`              | Name of the MongoDB Atlas project.                                          |
| `mongodbatlas_org_id`       | Organization ID for the MongoDB Atlas project.                              |
| `mongodbatlas_public_key`   | Public API key for MongoDB Atlas.                                           |
| `mongodbatlas_private_key`  | Private API key for MongoDB Atlas.                                          |
| `cluster_name`              | Name of the MongoDB Atlas cluster.                                          |
| `user_password_users`       | List of users with password authentication.                                 |
| `iam_users`                 | List of users with IAM authentication.                                      |

### Example `terraform.tfvars`

```hcl
project_name = "my-project"
mongodbatlas_org_id = "1234567890abcdef12345678"
mongodbatlas_public_key = "your-public-key"
mongodbatlas_private_key = "your-private-key"
cluster_name = "my-cluster"

user_password_users = [
  {
    username = "user1"
    password = "password1"
    role_name = "readWrite"
  },
  {
    username = "user2"
    password = "password2"
    role_name = "read"
  }
]

iam_users = [
  {
    username = "arn:aws:iam::123456789012:role/role1"
    role_name = "readWrite"
  },
  {
    username = "arn:aws:iam::123456789012:role/role2"
    role_name = "read"
  }
]

# Modules
mongodb_user
This module creates MongoDB Atlas database users with either password or IAM authentication.

backup_schedule_and_snapshot
This module creates backup snapshots and schedules for the MongoDB Atlas cluster.