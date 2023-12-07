resource "google_compute_address" "prj_b_psc_address" {
  project      = var.project_b
  name         = "prj-b-psc-address"
  subnetwork   = google_compute_subnetwork.prj_b_subnet.id
  address_type = "INTERNAL"
  address      = "10.200.0.240"
  region       = var.region
}

resource "google_compute_forwarding_rule" "prj_b_psc_endpoint" {
  project                 = var.project_b
  name                    = "prj-b-psc-endpoint"
  region                  = var.region
  load_balancing_scheme   = ""
  target                  = google_sql_database_instance.prj_a_mysql_test.psc_service_attachment_link
  network                 = google_compute_network.prj_b_vpc.id
  ip_address              = google_compute_address.prj_b_psc_address.id
  allow_psc_global_access = true
}
