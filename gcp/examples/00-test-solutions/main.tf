provider "google" {
  credentials = file("terraform-gcp-creds.json")
  project = var.gcloud_project_id
  region = var.region
  zone = "${var.region}-b"
}   

resource "google_compute_address" "static_ip" {
  name = "gcp-static-ip"
}

resource "google_compute_instance" "server" {
    name         = "gcp-server"
    machine_type = "e2-micro"
    tags         = ["web-server"]
    
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-12"
        }
    }
    network_interface {
        network = "default"
        access_config {
            nat_ip = google_compute_address.static_ip.address
        }
    }

    metadata_startup_script = file("startup-script.sh")
}

resource "google_compute_firewall" "allow_http_ssh_https" {
  name    = "allow-http-ssh-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}