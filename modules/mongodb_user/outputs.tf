output "custom_role_name" {
  description = "Name of the custom database role"
  value       = mongodbatlas_custom_db_role.custom_role.role_name
}

output "user_with_password_usernames" {
  description = "Usernames of the password-authenticated users"
  value       = { for k, user in mongodbatlas_database_user.user_with_password : k => user.username }
}

output "user_with_iam_usernames" {
  description = "Usernames of the IAM-authenticated users"
  value       = { for k, user in mongodbatlas_database_user.user_with_iam : k => user.username }
}