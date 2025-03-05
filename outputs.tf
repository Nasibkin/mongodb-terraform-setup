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

output "snapshot_ids" {
  description = "IDs of the created snapshots"
  value       = module.backup_schedule_and_snapshot.snapshot_ids
}

output "backup_schedule_ids" {
  description = "IDs of the created backup schedules"
  value       = module.backup_schedule_and_snapshot.backup_schedule_ids
}