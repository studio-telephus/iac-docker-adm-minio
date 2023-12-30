provider "minio" {
  minio_server   = var.provider_server
  minio_user     = var.provider_user
  minio_password = var.provider_password
}
