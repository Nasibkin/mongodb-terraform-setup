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

variable "username" {
  description = "Username for the database user"
  type        = string
}

variable "password" {
  description = "Password for the database user"
  type        = string
  sensitive   = true
}

variable "iam_username" {
  description = "Username for the IAM-authenticated database user"
  type        = string
}

variable "role_name" {
  description = "Role to assign to the database user (e.g., readAnyDatabase, atlasAdmin, customRole)"
  type        = string
  default     = "readAnyDatabase"
}

variable "role_name_iam" {
  description = "Role to assign to the database user (e.g., readAnyDatabase, atlasAdmin, customRole)"
  type        = string
  default     = "readAnyDatabase"
}