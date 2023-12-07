resource "google_compute_network" "prj_b_vpc" {
  project                 = var.project_b
  name                    = "prj-b-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode            = "REGIONAL"
  depends_on              = [google_project_service.prj_b_services]
}

resource "google_compute_subnetwork" "prj_b_subnet" {
  project                  = var.project_b
  name                     = "prj-b-subnet"
  ip_cidr_range            = "10.200.0.0/24"
  region                   = var.region
  network                  = google_compute_network.prj_b_vpc.id
  private_ip_google_access = true
}

resource "google_compute_router" "prj_b_nat_router" {
  project = var.project_b
  name    = "prj-b-nat-router"
  region  = var.region
  network = google_compute_network.prj_b_vpc.id
}

resource "google_compute_router_nat" "prj_b_nat_gw" {
  project                            = var.project_b
  name                               = "prj-b-nat-gw"
  router                             = google_compute_router.prj_b_nat_router.name
  region                             = google_compute_router.prj_b_nat_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_firewall" "prj_b_vpc_allow_ssh_via_iap" {
  project   = var.project_b
  name      = "prj-b-vpc-allow-ssh-via-iap"
  network   = google_compute_network.prj_b_vpc.id
  direction = "INGRESS"
  priority  = "1000"
  allow {
    protocol = "TCP"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["ssh"]
}
