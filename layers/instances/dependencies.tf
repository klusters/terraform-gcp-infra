data "terraform_remote_state" "network" {
  workspace = "wawa"
  backend   = "gcs"
  config = {
    bucket = "cdp-training-remote-tfstates"
    prefix = "network"
  }
}
