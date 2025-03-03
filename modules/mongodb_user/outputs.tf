output "custom_role_name" {
  description = "Name of the custom database role"
  value       = mongodbatlas_custom_db_role.custom_role.role_name
}

output "user_with_password_username" {
  description = "Username of the password-authenticated user"
  value       = mongodbatlas_database_user.user_with_password.username
}

output "user_with_iam_username" {
  description = "Username of the IAM-authenticated user"
  value       = mongodbatlas_database_user.user_with_iam.username
}