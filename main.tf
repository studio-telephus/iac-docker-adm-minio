locals {
  docker_image_name = "tel-${var.env}-minio"
  container_name    = "container-${var.env}-minio"
}

resource "docker_image" "minio" {
  name         = local.docker_image_name
  keep_locally = false
  build {
    context = path.module
    build_args = {
      _SERVER_KEY_PASSPHRASE = module.bw_minio_key_passphrase.data.password
    }
  }
  triggers = {
    dir_sha1 = sha1(join("", [
      filesha1("${path.module}/Dockerfile")
    ]))
  }
}

resource "docker_volume" "minio_data" {
  name = "volume-${var.env}-minio-data"
}

module "container_minio" {
  source   = "github.com/studio-telephus/terraform-docker-container.git?ref=1.0.2"
  name     = local.container_name
  hostname = local.container_name
  image    = docker_image.minio.image_id
  networks_advanced = [
    {
      name         = "${var.env}-docker"
      ipv4_address = "10.10.0.109"
    }
  ]
  environment = {
    MINIO_ROOT_USER     = module.bw_minio_root.data.username
    MINIO_ROOT_PASSWORD = module.bw_minio_root.data.password
  }
  mounts = [
    {
      target = "/mnt/data"
      source = docker_volume.minio_data.name
      type   = "volume"
    }
  ]
  command = ["supervisord"]
}
