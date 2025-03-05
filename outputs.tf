output "project_id" {
  value = mongodbatlas_project.projectA.id
}

output "cluster_name" {
  value = mongodbatlas_cluster.clusterA.name
}

output "custom_role_name" {
  value = module.mongodb_user.custom_role_name
}

output "password_users" {
  description = "Usernames of the password-authenticated users"
  value       = module.mongodb_user.user_with_password_usernames
}

output "iam_users" {
  description = "Usernames of the IAM-authenticated users"
  value       = module.mongodb_user.user_with_iam_usernames
}