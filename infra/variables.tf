variable "project_id" {
  description = "The unique identifier of the Google Cloud project where resources will be deployed. This is required to manage and associate all resources within the specified project."
  # Suggestion: Use ENV VARIABLES to pass it.
}

variable "project_number" {
  description = "GCP unique identifier project number."
  # Suggestion: Use ENV VARIABLES to pass it.
}

variable "region" {
  description = "The Google Cloud region where resources will be deployed. This determines the geographical location of the infrastructure and impacts latency, availability, and cost."
  default     = "us-east1"
}
