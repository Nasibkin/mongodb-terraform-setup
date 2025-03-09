resource "mongodbatlas_cloud_backup_snapshot" "snapshot" {
  for_each = var.snapshots

  project_id   = each.value.project_id
  cluster_name = each.value.cluster_name
  description  = each.value.description
  retention_in_days = each.value.retention_in_days
}

resource "mongodbatlas_cloud_backup_schedule" "backup_schedule" {
  for_each = var.backup_schedules

  project_id   = each.value.project_id
  cluster_name = each.value.cluster_name

  dynamic "policy_item_hourly" {
    for_each = each.value.policy_item_hourly != null ? [each.value.policy_item_hourly] : []
    content {
      frequency_interval = policy_item_hourly.value.frequency_interval
      retention_unit     = policy_item_hourly.value.retention_unit
      retention_value    = policy_item_hourly.value.retention_value
    }
  }

  dynamic "policy_item_daily" {
    for_each = each.value.policy_item_daily != null ? [each.value.policy_item_daily] : []
    content {
      frequency_interval = policy_item_daily.value.frequency_interval
      retention_unit     = policy_item_daily.value.retention_unit
      retention_value    = policy_item_daily.value.retention_value
    }
  }

  dynamic "policy_item_weekly" {
    for_each = each.value.policy_item_weekly != null ? [each.value.policy_item_weekly] : []
    content {
      frequency_interval = policy_item_weekly.value.frequency_interval
      retention_unit     = policy_item_weekly.value.retention_unit
      retention_value    = policy_item_weekly.value.retention_value
    }
  }

  dynamic "policy_item_monthly" {
    for_each = each.value.policy_item_monthly != null ? [each.value.policy_item_monthly] : []
    content {
      frequency_interval = policy_item_monthly.value.frequency_interval
      retention_unit     = policy_item_monthly.value.retention_unit
      retention_value    = policy_item_monthly.value.retention_value
    }
  }
}