provider "google" {
  credentials = file("<PATH_TO_YOUR_KEY_FILE>")
  project = "<PROJECT_ID>"
  region  = "<REGION>"
}

resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc"
  auto_create_subnetworks = true
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-vm"
  machine_type = "e2-medium"
  zone         = "<ZONE>"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.self_link
  }
}
