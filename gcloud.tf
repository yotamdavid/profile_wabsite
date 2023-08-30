provider "google" {
  credentials = file("/home/yotam/Desktop/golden-system-393111-1886b3d466d6.json")
  project     = "golden-system-393111"
  region      = "us-central1"
}

resource "google_container_cluster" "test" {
  name     = "test-cluster"
  location = "us-central1"
  enable_autopilot = true
}
