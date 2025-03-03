variable "mongodbatlas_public_key" {
  description = "MongoDB Atlas Public Key"
  type        = string
}

variable "mongodbatlas_private_key" {
  type        = string
  sensitive   = true
}

variable "mongodbatlas_org_id" {
  type        = string
}

variable "project_name" {
  type        = string
}

variable "cluster_name" {
  type        = string
}

variable "username" {
  type        = string
  default     = "myuser"
}

variable "password" {
  type        = string
  default     = "mypassword"
}

variable "iam_username" {
  type        = string
}

variable "role_name" {
  description = "Use readAnyDatabase, atlasAdmin, or customRole"
  type        = string
  default     = "customRole"  
}

variable "role_name_iam" {
  description = "Role to assign to the database user (e.g., readAnyDatabase, atlasAdmin, customRole)"
  type        = string
  default     = "readAnyDatabase"
}