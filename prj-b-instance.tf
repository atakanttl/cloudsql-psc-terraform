resource "google_compute_instance" "prj_b_test_vm" {
  project        = var.project_b
  name           = "prj-b-test-vm"
  machine_type   = "e2-micro"
  zone           = data.google_compute_zones.available.names[0]
  desired_status = "RUNNING"

  tags = ["ssh"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.prj_b_subnet.id
    network_ip = "10.200.0.5"
  }

  metadata_startup_script = "apt-get update && apt-get install -y mysql-client"

  service_account {
    scopes = []
  }
}

data "google_compute_zones" "available" {
  project    = var.project_b
  region     = var.region
  status     = "UP"
  depends_on = [google_project_service.prj_b_services]
}
