variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable db_disk_image {
  description = "DB Disk image"
  default     = "reddit-base"
}

variable app_disk_image {
  description = "App Disk image"
  default     = "reddit-app-base"
}
