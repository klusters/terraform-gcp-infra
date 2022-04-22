terraform {
  backend "gcs" {
    bucket = "altus-le-1er-tfstates"
    prefix = "gce"
  }
}