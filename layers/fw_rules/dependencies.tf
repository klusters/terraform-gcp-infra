data "terraform_remote_state" "network" {
  workspace = "lab-ses"
  backend   = "gcs"
  config = {
    bucket = "cdp-training-ses-remote-tfstates"
    prefix = "network"
  }
}
