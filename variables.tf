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

variable "cw_custom_metric_namespace" {
  description = "Name of the custom metric namespace"
  type        = string
  default     = "CloudTrailLogMetrics"
}

variable "cw_custom_metric_name" {
  description = "Name of the custom metric name"
  type        = string
  default     = "KMSKeyPendingDeletionErrorCount"
}

variable "sns_topic_name" {
  description = "Name of the SNS topic where the alarms will be send"
  type        = string
  default     = "kms-use-deleted-key-topic"
}

variable "sns_subscription_emails" {
  description = "List of emails to be notified when the CloudWatch alarm is triggered"
  type        = set(string)
  default     = ["abc123@gmail.com"]
  validation {
    error_message = "List must contain only valid email addresses!"
    condition     = alltrue([for addr in var.sns_subscription_emails : can(regex("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$", addr))])
  }
}

variable "tags" {
  description = "Tags to be applied to all created resources"
  type        = map(string)
  default = {
    CreatedBy = "Terraform"
  }
}
