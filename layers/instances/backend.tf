terraform {
  backend "gcs" {
    bucket = "cdp-training-remote-tfstates"
    prefix = "cdp-cluster-instances"
  }
}