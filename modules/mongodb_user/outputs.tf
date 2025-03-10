output "custom_role_names" {
  description = "Names of the custom database roles"
  value       = { for k, role in mongodbatlas_custom_db_role.custom_role : k => role.role_name }
}

output "user_with_password_usernames" {
  description = "Usernames of the password-authenticated users"
  value       = { for k, user in mongodbatlas_database_user.user_with_password : k => user.username }
}

output "user_with_iam_usernames" {
  description = "Usernames of the IAM-authenticated users"
  value       = { for k, user in mongodbatlas_database_user.user_with_iam : k => user.username }
}