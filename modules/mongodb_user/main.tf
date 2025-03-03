resource "mongodbatlas_custom_db_role" "custom_role" {
  project_id = var.project_id
  role_name  = "customRole"

  actions {
    action = "UPDATE"
    resources {
      collection_name = ""
      database_name   = "admin" # insert your_database name, because in MongoDB, roles are database-specific
    }
  }
  actions {
    action = "INSERT"
    resources {
      collection_name = ""
      database_name   = "admin"
    }
  }
  actions {
    action = "REMOVE"
    resources {
      collection_name = ""
      database_name   = "admin"
    }
  }
  actions {
    action = "FIND"
    resources {
      collection_name = ""
      database_name   = "admin"
    }
  }
}

resource "mongodbatlas_database_user" "user_with_password" {
  username           = var.username
  password           = var.password
  project_id         = var.project_id
  auth_database_name = "admin"

  roles {
    role_name     = var.role_name == "customRole" ? mongodbatlas_custom_db_role.custom_role.role_name : var.role_name
    database_name = "admin"
  }
}

resource "mongodbatlas_database_user" "user_with_iam" {
  project_id         = var.project_id
  username           = var.iam_username
  auth_database_name = "$external"

  aws_iam_type = "ROLE"
  roles {
    role_name     = var.role_name_iam == "customRole" ? mongodbatlas_custom_db_role.custom_role.role_name : var.role_name_iam
    database_name = "admin"
  }
}