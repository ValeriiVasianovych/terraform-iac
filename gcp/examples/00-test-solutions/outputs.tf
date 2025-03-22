output "project_id" {
  value = var.gcloud_project_id
}

output "instance_name" {
  value = google_compute_instance.server.name
}

output "instance_zone" {
  value = google_compute_instance.server.zone
}

output "instance_id" {
  value = google_compute_instance.server.id
}

output "instance_network" {
  value = google_compute_instance.server.network_interface.0.network
}

output "public_ip" {
  value = google_compute_address.static_ip.address
}