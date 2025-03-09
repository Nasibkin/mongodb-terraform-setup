resource "mongodbatlas_project" "projectA" {
  name   = var.project_name
  org_id = var.mongodbatlas_org_id

  tags = {
    Environment = "Test"
  }
}

resource "mongodbatlas_cluster" "clusterA" {
  project_id = mongodbatlas_project.projectA.id
  name       = var.cluster_name

  auto_scaling_compute_enabled                    = true
  auto_scaling_compute_scale_down_enabled         = true
  cluster_type                                    = "REPLICASET"
  cloud_backup                                    = true
  auto_scaling_disk_gb_enabled                    = true
  mongo_db_major_version                          = "8.0"
  provider_name                                   = "AWS"
  provider_instance_size_name                     = "M10"
  provider_region_name                            = "US_EAST_1"
  disk_size_gb                                    = 10
  provider_disk_iops                              = 3000
  provider_volume_type                            = "STANDARD"
  pit_enabled                                     = true
  termination_protection_enabled                  = false
  provider_auto_scaling_compute_min_instance_size = "M10"
  provider_auto_scaling_compute_max_instance_size = "M20"

  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = "US_EAST_1"
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
      analytics_nodes = 0
    }
  }

  bi_connector_config {
    enabled         = false
    read_preference = "secondary"
  }
}

module "mongodb_user" {
  source = "./modules/mongodb_user"

  mongodbatlas_public_key  = var.mongodbatlas_public_key
  mongodbatlas_private_key = var.mongodbatlas_private_key
  project_id               = mongodbatlas_project.projectA.id

  custom_roles = var.custom_roles

  iam_users = var.iam_users

  user_password_users = [
    {
      username           = "test"
      password           = "dummypassword"
      auth_database_name = "admin"
      roles = [
        {
          role_name     = "readWrite"
          database_name = "admin"
        }
      ]
    }
  ]
}

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
    snapshot2 = {
      project_id        = mongodbatlas_project.projectA.id
      cluster_name      = mongodbatlas_cluster.clusterA.name
      description       = "Weekly snapshot"
      retention_in_days = 31
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
  bs2 = {
    project_id   = mongodbatlas_project.projectA.id
    cluster_name = mongodbatlas_cluster.clusterA.name
    policy_item_hourly = {
      frequency_interval = 1
      retention_unit     = "days"
      retention_value    = 7 
    }
    policy_item_weekly = {
      frequency_interval = 1
      retention_unit     = "weeks"
      retention_value    = 4
    }
    policy_item_monthly = {
      frequency_interval = 1
      retention_unit     = "months"
      retention_value    = 12
    }
  }
}
}