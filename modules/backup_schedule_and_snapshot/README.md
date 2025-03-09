# MongoDB Atlas Backup Schedule and Snapshot Module

This Terraform module automates the creation of backup snapshots and schedules for MongoDB Atlas clusters. It allows you to define multiple snapshots and backup schedules with customizable retention policies.

## 🚀 Features

- **Backup Snapshots**: Create on-demand snapshots for MongoDB Atlas clusters with configurable retention periods.
- **Backup Schedules**: Define hourly, daily, weekly, and monthly backup schedules with customizable retention policies.

---

## 📌 Usage

### 🔧 Inputs

The following input variables are required:

| Variable Name               | Description |
|-----------------------------|-------------|
| `mongodbatlas_public_key`   | Public API key for MongoDB Atlas. |
| `mongodbatlas_private_key`  | Private API key for MongoDB Atlas. |
| `snapshots`                 | Map of snapshot configurations. Each snapshot requires: <ul><li>`project_id` - The ID of the MongoDB Atlas project.</li><li>`cluster_name` - The name of the cluster.</li><li>`description` - A description of the snapshot.</li><li>`retention_in_days` - The number of days to retain the snapshot.</li></ul> |
| `backup_schedules`          | Map of backup schedule configurations. Each schedule requires: <ul><li>`project_id` - The ID of the MongoDB Atlas project.</li><li>`cluster_name` - The name of the cluster.</li><li>Optional policy configurations:<ul><li>`policy_item_hourly`</li><li>`policy_item_daily`</li><li>`policy_item_weekly`</li><li>`policy_item_monthly`</li></ul> Each policy item requires:<ul><li>`frequency_interval` - The frequency of the backup.</li><li>`retention_unit` - The unit of retention (e.g., days, weeks, months).</li><li>`retention_value` - The number of units to retain the backup.</li></ul></li></ul> |

---

### 📘 Example Usage

```hcl
module "backup_schedule_and_snapshot" {
  source = "./modules/backup_schedule_and_snapshot"

  mongodbatlas_public_key  = var.mongodbatlas_public_key
  mongodbatlas_private_key = var.mongodbatlas_private_key

  snapshots = {
    snapshot1 = {
      project_id        = mongodbatlas_project.projectA.id
      cluster_name      = mongodbatlas_cluster.clusterA.name
      description       = "Daily snapshot"
      retention_in_days = 7
    }
  }

  backup_schedules = {
    bs1 = {
      project_id   = mongodbatlas_project.projectA.id
      cluster_name = mongodbatlas_cluster.clusterA.name
      policy_item_hourly = {
        frequency_interval = 1
        retention_unit     = "days"
        retention_value    = 7
      }
      policy_item_daily = {
        frequency_interval = 1
        retention_unit     = "days"
        retention_value    = 8
      }
    }
  }
}
```

---

### 📤 Outputs

This module provides the following outputs:

| Output Name         | Description |
|---------------------|-------------|
| `snapshot_ids`      | A map of snapshot IDs, keyed by the snapshot name. |
| `backup_schedule_ids` | A map of backup schedule IDs, keyed by the schedule name. |

#### Example Outputs

```hcl
snapshot_ids = {
  snapshot1 = "5f5b5a5e5d5c5b5a5e5d5c5b"
}

backup_schedule_ids = {
  bs1 = "5f5b5a5e5d5c5b5a5e5d5c5a"
}
```

---

## ✅ Prerequisites

- MongoDB Atlas API keys with sufficient permissions to create snapshots and backup schedules.
- Terraform installed and configured.

---