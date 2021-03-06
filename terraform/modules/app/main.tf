resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой нужно присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    sshKeys = "appuser:${file(var.public_key_path)}"
  }

  tags = ["reddit-app"]

  #   connection {
  #     type        = "ssh"
  #     user        = "appuser"
  #     agent       = false
  #     private_key = "${file(var.private_key_path)}"
  #   }
  # 
  #   provisioner "file" {
  #     source      = "files/puma.service"
  #     destination = "/tmp/puma.service"
  #   }
  # 
  #   provisioner "remote-exec" {
  #     script = "files/deploy.sh"
  #   }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Название сети, в которой действует правило
  network = "default"

  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  # Правило применимо для инстансов с тегом ...
  target_tags = ["reddit-app"]

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
}

resource "google_compute_address" "app_ip" {
  name   = "reddit-app-ip"
  region = "europe-west1"
}
