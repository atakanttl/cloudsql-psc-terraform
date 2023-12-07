locals {
  service_list = [
    "compute.googleapis.com"
  ]
}

resource "google_project_service" "prj_a_services" {
  project  = var.project_a
  for_each = toset(local.service_list)
  service  = each.key
}

resource "google_project_service" "prj_b_services" {
  project  = var.project_b
  for_each = toset(local.service_list)
  service  = each.key
}
