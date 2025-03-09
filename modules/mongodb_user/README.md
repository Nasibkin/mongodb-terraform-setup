# 🚀 MongoDB Atlas Database User Module

This Terraform module automates the creation of MongoDB Atlas database users, supporting both password-authenticated and IAM-authenticated users. It also enables defining custom database roles with specific permissions and allows users to have **multiple roles**, **labels**, and **scopes**.

---

## 🌟 Features

- 🎭 **Custom Database Roles** – Dynamically create custom roles with predefined actions.
- 🔑 **Password-Authenticated Users** – Create users with username and password authentication.
- 🔐 **IAM-Authenticated Users** – Create users with AWS IAM role-based authentication.
- 🎯 **Multiple Roles** – Assign multiple built-in or custom roles to users.
- 🏷 **Labels and Scopes** – Add labels and scopes to users for better organization and access control.

---

## 🔧 Inputs

The following input variables are supported:

| Variable Name               | Description |
|-----------------------------|-------------|
| `mongodbatlas_public_key`   | Public API key for MongoDB Atlas. |
| `mongodbatlas_private_key`  | Private API key for MongoDB Atlas. |
| `project_id`                | The ID of the MongoDB Atlas project. |
| `custom_roles`              | Map of custom roles to create. Each role requires:<ul><li>`role_name` - The name of the role.</li><li>`database_name` - The database the role applies to.</li></ul> |
| `iam_users`                 | List of IAM-authenticated users. Each user requires:<ul><li>`username` - The AWS IAM role ARN.</li><li>`auth_database_name` - The authentication database (`$external` for IAM).</li><li>`aws_iam_type` - The IAM type (`ROLE` or `USER`).</li><li>`roles` - List of roles assigned to the user.</li><li>`labels` - Optional list of labels for the user.</li><li>`scopes` - Optional list of scopes for the user.</li></ul> |
| `user_password_users`       | List of password-authenticated users. Each user requires:<ul><li>`username` - The username.</li><li>`password` - The password.</li><li>`auth_database_name` - The authentication database (`admin` for password users).</li><li>`roles` - List of roles assigned to the user.</li><li>`labels` - Optional list of labels for the user.</li><li>`scopes` - Optional list of scopes for the user.</li></ul> |

---

## 📘 Example Usage

```hcl
module "mongodb_user" {
  source = "./modules/mongodb_user"

  mongodbatlas_public_key  = var.mongodbatlas_public_key
  mongodbatlas_private_key = var.mongodbatlas_private_key
  project_id               = mongodbatlas_project.projectA.id

  # Define custom roles
  custom_roles = {
    application_rw = {
      role_name     = "ReadWriteapp"
      database_name = "example-db"
    },
    mongosync_bypass = {
      role_name     = "bypass"
      database_name = "example-db"
    }
  }

  # Define IAM-authenticated users
  iam_users = [
    {
      username           = "arn:aws:iam::123456789012:role/role1"
      auth_database_name = "$external"
      aws_iam_type       = "ROLE"
      roles = [
        {
          role_name     = "bypass"
          database_name = "admin"
        },
        {
          role_name     = "backup"
          database_name = "admin"
        }
      ]
      labels = [
        {
          key   = "environment"
          value = "production"
        }
      ]
      scopes = [
        {
          name = "cluster1"
          type = "CLUSTER"
        }
      ]
    }
  ]

  # Define password-authenticated users
  user_password_users = [
    {
      username           = "test"
      password           = "dummypassword"
      auth_database_name = "admin"
      roles = [
        {
          role_name     = "readWrite"
          database_name = "admin"
        }
      ]
    }
  ]
}
```

---

## 📤 Outputs

| Output Name                    | Description |
|---------------------------------|-------------|
| `custom_role_names`             | A map of custom role names, keyed by the role identifier. |
| `user_with_password_usernames`  | A map of usernames for password-authenticated users, keyed by their index. |
| `user_with_iam_usernames`       | A map of usernames for IAM-authenticated users, keyed by their index. |

### 🎯 Example Outputs

```hcl
custom_role_names = {
  application_rw = "ReadWriteapp"
  mongosync_bypass = "bypass"
}

user_with_password_usernames = {
  0 = "test"
}

user_with_iam_usernames = {
  0 = "arn:aws:iam::123456789012:role/role1"
}
```

---

## ✅ Prerequisites

- **MongoDB Atlas API Keys** – Generate API keys from the MongoDB Atlas UI under **Access Management > API Keys**.
- **Terraform** – Ensure Terraform is installed. Download it from [here](https://www.terraform.io/downloads.html).
- **AWS IAM Roles** – If using IAM authentication, ensure the necessary IAM roles are created in AWS.

---

## 📝 Notes

- **Custom Roles** – Predefined actions for custom roles are defined in `locals.tf`. You can modify or extend these actions as needed.
- **Scopes** – Scopes allow you to restrict user access to specific clusters or databases.

---