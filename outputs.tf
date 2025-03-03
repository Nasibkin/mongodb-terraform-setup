output "project_id" {
  value = mongodbatlas_project.projectA.id
}

output "cluster_name" {
  value = mongodbatlas_cluster.cluster-test.name
}

output "custom_role_name" {
  value = module.mongodb_user.custom_role_name
}

output "database_users" {
  value = {
    user_with_password = module.mongodb_user.user_with_password_username
    user_with_iam = module.mongodb_user.user_with_iam_username
  }
}