variable "project_id" {
  type        = string
  description = "project_id"
}

variable "region_name" {
  type        = string
  description = "region名"
}

variable "zone_name" {
  type        = string
  description = "zone名"
}

variable "service_name" {
  type        = string
  description = "サービス名"
}

variable "labels" {
  type = object({
    project = string
    service = string
  })
}

variable "pod_ip_range_name" {
  type        = string
  description = "PodのIP範囲名"
}

variable "service_ip_range_name" {
  type        = string
  description = "ServiceのIP範囲名"
}
