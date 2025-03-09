resource "mongodbatlas_custom_db_role" "custom_role" {
  for_each = var.custom_roles

  project_id = var.project_id
  role_name  = each.value.role_name

  dynamic "actions" {
    for_each = each.value.actions
    content {
      action = actions.value.action
      resources {
        collection_name = actions.value.resources[0].collection_name
        database_name   = actions.value.resources[0].database_name
      }
    }
  }
}

resource "mongodbatlas_database_user" "user_with_iam" {
  for_each = { for idx, user in var.iam_users : idx => user }

  project_id         = var.project_id
  username           = each.value.username
  auth_database_name = each.value.auth_database_name
  aws_iam_type       = each.value.aws_iam_type

  dynamic "roles" {
    for_each = each.value.roles
    content {
      role_name     = roles.value.role_name
      database_name = roles.value.database_name
    }
  }

  dynamic "labels" {
    for_each = each.value.labels != null ? each.value.labels : []
    content {
      key   = labels.value.key
      value = labels.value.value
    }
  }

  dynamic "scopes" {
    for_each = each.value.scopes != null ? each.value.scopes : []
    content {
      name = scopes.value.name
      type = scopes.value.type
    }
  }

  lifecycle {
    ignore_changes = [password]
  }

  depends_on = [mongodbatlas_custom_db_role.custom_role]
}

resource "mongodbatlas_database_user" "user_with_password" {
  for_each = { for idx, user in var.user_password_users : idx => user }

  project_id         = var.project_id
  username           = each.value.username
  password           = each.value.password
  auth_database_name = each.value.auth_database_name

  dynamic "roles" {
    for_each = each.value.roles
    content {
      role_name     = roles.value.role_name
      database_name = roles.value.database_name
    }
  }

  dynamic "labels" {
    for_each = each.value.labels != null ? each.value.labels : []
    content {
      key   = labels.value.key
      value = labels.value.value
    }
  }

  dynamic "scopes" {
    for_each = each.value.scopes != null ? each.value.scopes : []
    content {
      name = scopes.value.name
      type = scopes.value.type
    }
  }

  lifecycle {
    ignore_changes = [password]
  }
}