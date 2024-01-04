module "container_adm_minio" {
  source    = "github.com/studio-telephus/terraform-lxd-instance.git?ref=1.0.3"
  name      = "container-adm-minio"
  image     = "images:debian/bookworm"
  profiles  = ["limits", "fs-dir", "nw-adm"]
  autostart = true
  nic = {
    name = "eth0"
    properties = {
      nictype        = "bridged"
      parent         = "adm-network"
      "ipv4.address" = var.container_ipv4_address
    }
  }
  mount_dirs = [
    "${path.cwd}/filesystem",
  ]
  exec_enabled = true
  exec         = "/mnt/install.sh"
  environment = {
    RANDOM_STRING         = "c563ccc3-49e0-46de-990f-1146d04f6257"
    MINIO_ROOT_USER       = var.minio_root_user
    MINIO_ROOT_PASSWORD   = var.minio_root_password
    SERVER_KEY_PASSPHRASE = var.minio_key_passphrase
  }
}
