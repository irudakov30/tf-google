variable "token" {
  type = string
}

variable "projectId" {
  type = string
}

variable "region" {
  type = string
}

provider "google" {
  access_token = var.token
  project = var.projectId
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc"
  auto_create_subnetworks = true
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-vm"
  machine_type = "e2-small"
  zone         = "europe-west3"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.self_link
  }
}
