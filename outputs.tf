output "mysql_test_password" {
  value     = random_password.mysql_test_password.result
  sensitive = true
}

output "compute_instance_zone" {
  value = google_compute_instance.prj_b_test_vm.zone
}

