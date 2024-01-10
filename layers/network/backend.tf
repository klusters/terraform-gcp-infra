terraform {
  backend "gcs" {
    bucket = "cdp-training-ses-remote-tfstates"
    prefix = "network"
  }
}