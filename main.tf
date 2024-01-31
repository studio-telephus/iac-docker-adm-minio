locals {
  docker_image_name = "tel-adm-minio"
  container_name    = "container-adm-minio"
}

resource "docker_image" "nameserver" {
  name         = local.docker_image_name
  keep_locally = false
  build {
    context = path.module
    build_args = {
      SERVER_KEY_PASSPHRASE = module.bw_minio_key_passphrase.data.password
    }
  }
}

module "container_adm_minio" {
  source = "github.com/studio-telephus/terraform-docker-container.git?ref=1.0.1"
  name   = local.container_name
  image  = docker_image.nameserver.image_id
  networks_advanced = [
    {
      name         = "adm-docker"
      ipv4_address = "10.10.0.109"
    }
  ]
  environment = {
    MINIO_ROOT_USER       = module.bw_minio_root.data.username
    MINIO_ROOT_PASSWORD   = module.bw_minio_root.data.password
  }
  command = ["supervisord"]
}
