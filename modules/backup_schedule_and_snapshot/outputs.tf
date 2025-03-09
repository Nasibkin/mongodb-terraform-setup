output "snapshot_ids" {
  description = "IDs of the created snapshots"
  value       = { for k, v in mongodbatlas_cloud_backup_snapshot.snapshot : k => v.id }
}

output "backup_schedule_ids" {
  description = "IDs of the created backup schedules"
  value       = { for k, v in mongodbatlas_cloud_backup_schedule.backup_schedule : k => v.id }
}