variable "mongodbatlas_public_key" {
  description = "MongoDB Atlas Public Key"
  type        = string
}

variable "mongodbatlas_private_key" {
  type        = string
  sensitive   = true
}

variable "snapshots" {
  type = map(object({
    project_id         = string
    cluster_name       = string
    description        = string
    retention_in_days  = number
  }))
  description = "Map of snapshot configurations"
}

variable "backup_schedules" {
  type = map(object({
    project_id         = string
    cluster_name       = string
    policy_item_hourly = optional(object({
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
    }))
    policy_item_daily = optional(object({
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
    }))
    policy_item_weekly = optional(object({
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
    }))
    policy_item_monthly = optional(object({
      frequency_interval = number
      retention_unit     = string
      retention_value    = number
    }))
  }))
  description = "Map of backup schedule configurations"
}