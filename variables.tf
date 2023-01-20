variable "s3_bucket_name" {
  description = "Name of the bucket where the trail logs are stored"
  type        = string
  default     = "000-super-trail-content-999"
}

variable "s3_bucket_force_destroy" {
  description = "Force the destruction of the bucket"
  type        = bool
  default     = true
}

variable "trail_name" {
  description = "Name of the trail"
  type        = string
  default     = "watch-deleted-kms-keys"
}

variable "cw_log_group_name" {
  description = "Name of CloudWatch log group"
  type        = string
  default     = "kms-trail-log-group"
}

variable "put_cw_role_name" {
  description = "Name of the role to be used to put logs into CloudWatch"
  type        = string
  default     = "kms-trail-logs-role"
}

variable "tags" {
  description = "Tags to be applied to all created resources"
  type        = map(string)
  default = {
    CreatedBy = "Terraform"
  }
}
