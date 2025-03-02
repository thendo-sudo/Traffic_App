provider "google" {
  project = "trafficflow-2025"
  region  = "us-central1"
}

resource "google_container_cluster" "traffic_cluster" {
  name     = "traffic-cluster"
  location = "us-central1"  # Regional cluster (spreads across zones)

  # Enable multi-zonal node pools
  node_locations = [
    "us-central1-a"
  ]

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "traffic_node_pool" {
  name       = "traffic-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.traffic_cluster.name
  node_count = 1

  node_config {
    machine_type = "e2-medium"
  }
}