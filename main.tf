resource "mongodbatlas_project" "projectA" {
  name   = var.project_name
  org_id = var.mongodbatlas_org_id

   tags = {
    Environment = "Test"
  }
}

resource "mongodbatlas_cluster" "cluster-test" {
  project_id   = mongodbatlas_project.projectA.id
  name         = var.cluster_name

  provider_name               = "TENANT" # free-tier
#   provider_name               = "AWS" 
  backing_provider_name       = "AWS" 
  provider_region_name        = "US_EAST_1"
  provider_instance_size_name = "M0"

  auto_scaling_disk_gb_enabled = false
  mongo_db_major_version       = "8.0"  
  disk_size_gb                 = 0.5 

  cluster_type = "REPLICASET"

  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = "US_EAST_1"
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }
}

module "mongodb_user" {
  source      = "./modules/mongodb_user"
  project_id  = mongodbatlas_project.projectA.id
  mongodbatlas_public_key  = var.mongodbatlas_public_key
  mongodbatlas_private_key = var.mongodbatlas_private_key
  username    = var.username
  password    = var.password
  iam_username = var.iam_username
  role_name   = var.role_name 
  role_name_iam = var.role_name_iam 
}