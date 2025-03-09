# 🚀 MongoDB Atlas Database User Module

This Terraform module automates the creation of MongoDB Atlas database users, supporting both password-authenticated and IAM-authenticated users. It also enables defining custom database roles with specific permissions.

---

## 🌟 Features

- 🔑 **Password-Authenticated Users** – Create users with username and password authentication.
- 🔐 **IAM-Authenticated Users** – Create users with AWS IAM role-based authentication.
- 🎭 **Custom Database Roles** – Define custom roles with specific actions and permissions.

---

## 🔧 Inputs

The following input variables are required:

| Variable Name               | Description |
|-----------------------------|-------------|
| `mongodbatlas_public_key`   | Public API key for MongoDB Atlas. |
| `mongodbatlas_private_key`  | Private API key for MongoDB Atlas. |
| `project_id`                | The ID of the MongoDB Atlas project. |
| `user_password_users`       | List of password-authenticated users. Each user requires:<ul><li>`username` - The username.</li><li>`password` - The password.</li><li>`role_name` - The role assigned to the user (e.g., `readWrite`, `read`, or `customRole`).</li></ul> |
| `iam_users`                 | List of IAM-authenticated users. Each user requires:<ul><li>`username` - The AWS IAM role ARN.</li><li>`role_name` - The role assigned to the user (e.g., `readWrite`, `read`, or `customRole`).</li></ul> |

---

## 📘 Example Usage

```hcl
module "mongodb_user" {
  source = "./modules/mongodb_user"

  mongodbatlas_public_key  = var.mongodbatlas_public_key
  mongodbatlas_private_key = var.mongodbatlas_private_key
  project_id               = mongodbatlas_project.projectA.id

  user_password_users = [
    {
      username  = "user1"
      password  = "password1"
      role_name = "readWrite"
    },
    {
      username  = "user2"
      password  = "password2"
      role_name = "read"
    }
  ]

  iam_users = [
    {
      username  = "arn:aws:iam::123456789012:role/role1"
      role_name = "readWrite"
    },
    {
      username  = "arn:aws:iam::123456789012:role/role2"
      role_name = "read"
    }
  ]
}
```

---

## 📤 Outputs

| Output Name                    | Description |
|---------------------------------|-------------|
| `custom_role_name`              | The name of the custom database role created. |
| `user_with_password_usernames`  | A map of usernames for password-authenticated users, keyed by their index. |
| `user_with_iam_usernames`       | A map of usernames for IAM-authenticated users, keyed by their index. |

### 🎯 Example Outputs

```hcl
custom_role_name = "customRole"

user_with_password_usernames = {
  0 = "user1"
  1 = "user2"
}

user_with_iam_usernames = {
  0 = "arn:aws:iam::123456789012:role/role1"
  1 = "arn:aws:iam::123456789012:role/role2"
}
```

---

## ✅ Prerequisites

- MongoDB Atlas API keys with sufficient permissions to create database users and roles.
- Terraform installed and configured.

---