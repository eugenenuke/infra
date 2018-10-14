resource "google_compute_firewall" "firewall_ssh" {
  name          = "default-allow-ssh"
  network       = "default"
  source_ranges = "${var.source_ranges}"
  priority      = "65534"
  description   = "Allow SSH from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
