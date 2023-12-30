variable "provider_server" {
  type = string
}

variable "provider_user" {
  type      = string
  sensitive = true
}

variable "provider_password" {
  type      = string
  sensitive = true
}

variable "bucket_name" {
  type = string
}

variable "user_name" {
  type      = string
  sensitive = true
}

variable "user_secret" {
  type      = string
  sensitive = true
}
