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

variable "vpc_name" {
  type        = string
  description = "VPC"
}

variable "manage_subnet_name" {
  type        = string
  description = "管理クラスタ用サブネット"
}

variable "workload_subnet_name" {
  type        = string
  description = "ワークロード用サブネット"
}

variable "labels" {
  type = object({
    project = string
    service = string
  })
}

variable "pod_ip_range_name" {
  type        = string
  description = "PodのIP範囲"
}

variable "service_ip_range_name" {
  type        = string
  description = "ServiceのIP範囲"
}