
variable "ssh_user" {
  type = string
  default = "aj"
}

variable "region"{
    type = string
    default = "europe-west2"
}

variable "private_key_path" {
type = string
default = "/Users/aj/.ssh/id_rsa"
}