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
  default     = "trail-log-group"
}

variable "cw_log_metric_filter_name" {
  description = "Name of CloudWatch log group filter"
  type        = string
  default     = "kms-use-deleted-key-filter"
}

variable "cw_alarm_name" {
  description = "Name of CloudWatch alarm to be created"
  type        = string
  default     = "kms-use-deleted-key-alarm"
}

variable "put_cw_role_name" {
  description = "Name of the role to be used to put logs into CloudWatch"
  type        = string
  default     = "kms-trail-logs-role"
}

variable "put_cw_role_boundary" {
  description = "Name of the boundary (if applicable) to be applied to the CloudWatch role"
  type        = string
  default     = ""
}

variable "sns_topic_name" {
  description = "Name of the SNS topic where the alarms will be send"
  type        = string
  default     = "kms-trail-logs-alarm"
}

variable "tags" {
  description = "Tags to be applied to all created resources"
  type        = map(string)
  default = {
    CreatedBy = "Terraform"
  }
}
