/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  cluster_type           = "test-iac-k8s"
  network_name           = "${local.cluster_type}-vpc"
  subnet_name            = "${local.cluster_type}-subnet"
  master_auth_subnetwork = "${local.cluster_type}-master-subnet"
  pods_range_name        = "ip-range-pods-${local.cluster_type}"
  svc_range_name         = "ip-range-svc-${local.cluster_type}"
  subnet_names           = [for subnet_self_link in module.gcp-network.subnets_self_links : split("/", subnet_self_link)[length(split("/", subnet_self_link)) - 1]]
}

data "google_client_config" "default" {}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-public-cluster"
  version = ">= 36.0"

  project_id                      = var.project_id
  name                            = "${local.cluster_type}-cluster"
  regional                        = true
  region                          = var.region
  network                         = module.gcp-network.network_name
  subnetwork                      = local.subnet_names[index(module.gcp-network.subnets_names, local.subnet_name)]
  ip_range_pods                   = local.pods_range_name
  ip_range_services               = local.svc_range_name
  release_channel                 = "RAPID"
  enable_vertical_pod_autoscaling = true
  # horizontal_pod_autoscaling      = false  "Must be enable for Autopilot cluster"
  # network_tags                    = [local.cluster_type]
  node_pools_cgroup_mode = "CGROUP_MODE_V2"
  deletion_protection    = false
  # enable_l4_ilb_subsetting = true
  # stateful_ha              = false
  gke_backup_agent_config = false
  ray_operator_config = {
    enabled            = true
    logging_enabled    = true
    monitoring_enabled = true
  }
}

### Allow kustomize to deploy ###
resource "google_project_iam_member" "default_gke_cluster_admin" {
  project = var.project_id
  role    = "roles/container.clusterAdmin"
  member  = "serviceAccount:${var.project_number}-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "gke_cluster_admin" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${var.project_number}-compute@developer.gserviceaccount.com"
}