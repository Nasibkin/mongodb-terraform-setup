variable "mongodbatlas_public_key" {
  description = "MongoDB Atlas Public Key"
  type        = string
}

variable "mongodbatlas_private_key" {
  type        = string
  sensitive   = true
}

variable "project_id" {
  description = "MongoDB Atlas Project ID"
  type        = string
}

variable "custom_roles" {
  type = map(object({
    role_name     = string
    database_name = string
    actions = list(object({
      action = string
      resources = list(object({
        collection_name = string
        database_name   = string
      }))
    }))
  }))
  default = {}
}

variable "iam_users" {
  type = list(object({
    username           = string
    auth_database_name = string
    aws_iam_type       = string
    roles = list(object({
      role_name     = string
      database_name = string
    }))
    labels = optional(list(object({
      key   = string
      value = string
    })))
    scopes = optional(list(object({
      name = string
      type = string
    })))
  }))
  default = []
}

variable "user_password_users" {
  type = list(object({
    username           = string
    password           = string
    auth_database_name = string
    roles = list(object({
      role_name     = string
      database_name = string
    }))
    labels = optional(list(object({
      key   = string
      value = string
    })))
    scopes = optional(list(object({
      name = string
      type = string
    })))
  }))
  default = []
}