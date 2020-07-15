resource "google_compute_instance" "tfer--terraformer-002D-test" {
  boot_disk {
    auto_delete = "true"
    device_name = "terraformer-test"

    initialize_params {
      image = "https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-10-buster-v20200618"
      size  = "10"
      type  = "pd-standard"
    }

    mode   = "READ_WRITE"
  }

  can_ip_forward      = "false"
  deletion_protection = "false"
  enable_display      = "false"
  machine_type        = "f1-micro"
  name                = "terraformer-test"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    network            = "https://www.googleapis.com/compute/v1/projects/sam-gabrail-gcp-demos/global/networks/default"
  }

  project = "sam-gabrail-gcp-demos"

  scheduling {
    automatic_restart   = "true"
    on_host_maintenance = "MIGRATE"
    preemptible         = "false"
  }

  service_account {
    email  = "330044736238-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/trace.append", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/devstorage.read_only"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "false"
    enable_vtpm                 = "true"
  }

  zone = "us-central1-f"
}
