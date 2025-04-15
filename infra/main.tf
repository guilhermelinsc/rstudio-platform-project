module "gke_autopilot" {
  source         = "./modules/"
  project_id     = var.project_id
  project_number = var.project_number
}