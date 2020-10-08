terraform {
  backend "gcs" {
    bucket = "github-ci-290307-actions-tfstates"
    prefix = "env/terraform-gcp-infra"
  }
}