terraform {
  backend "gcs" {
    bucket = "github-ci-carbide-haven-334802-tfstates"
    prefix = "gce"
  }
}