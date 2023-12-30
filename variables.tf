variable "container_ipv4_address" {
  type    = string
  default = "10.0.10.109"
}

variable "minio_key_passphrase" {
  type      = string
  sensitive = true
}

variable "minio_root_user" {
  default = "minio-admin"
}

variable "minio_root_password" {
  type      = string
  sensitive = true
}

variable "minio_terraform_sa_username" {
  type    = string
  default = "sa-minio-terraform"
}

variable "minio_terraform_sa_secret" {
  type      = string
  sensitive = true
}
