resource "google_sql_database_instance" "prj_a_mysql_test" {
  project          = var.project_a
  name             = "prj-a-mysql-test"
  database_version = "MYSQL_8_0"
  region           = var.region
  settings {
    tier = "db-g1-small"
    ip_configuration {
      psc_config {
        psc_enabled               = true
        allowed_consumer_projects = [var.project_a, var.project_b]
      }
      ipv4_enabled = false
    }
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }
    availability_type = "REGIONAL"
    edition           = "ENTERPRISE"
    disk_type         = "PD_HDD"
    disk_size         = 10
  }
  deletion_protection = false
  depends_on          = [google_project_service.prj_a_services]
}

resource "google_sql_user" "test" {
  project  = var.project_a
  name     = "test"
  instance = google_sql_database_instance.prj_a_mysql_test.name
  host     = "%"
  password = random_password.mysql_test_password.result
}

resource "random_password" "mysql_test_password" {
  length = 12
}
