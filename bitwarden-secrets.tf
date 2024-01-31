module "bw_minio_root" {
  source = "github.com/studio-telephus/terraform-bitwarden-get-item-login.git?ref=1.0.0"
  id     = "4f1dc27c-2bbe-4856-b4f4-b0f700648062"
}

module "bw_minio_key_passphrase" {
  source = "github.com/studio-telephus/terraform-bitwarden-get-item-login.git?ref=1.0.0"
  id     = "20c5e91f-d161-47b3-9be0-b0f70064b944"
}
