variable "mongodbatlas_public_key" {
  description = "MongoDB Atlas Public Key"
  type        = string
}

variable "mongodbatlas_private_key" {
  type      = string
  sensitive = true
}

variable "mongodbatlas_org_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "user_password_users" {
  type = list(object({
    username  = string
    password  = string
    role_name = string
  }))
  default = []
}

variable "iam_users" {
  type = list(object({
    username  = string
    role_name = string
  }))
  default = []
}