resource "aws_cloudwatch_log_group" "trail_log_group" {
  name = var.cw_log_group_name
  tags = var.tags
}

resource "aws_cloudwatch_log_metric_filter" "kms_use_deleted_key_filter" {
  name           = var.cw_log_metric_filter_name
  pattern        = "{ $.eventSource = kms* && $.errorMessage = \"* is pending deletion.\"}"
  log_group_name = aws_cloudwatch_log_group.trail_log_group.name

  metric_transformation {
    name      = "KMSKeyPendingDeletionErrorCount"
    namespace = "CloudTrailLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "kms_use_deleted_key_alarm" {
  alarm_name          = var.cw_alarm_name
  alarm_description   = "This metric monitors usage of pending deletion KMS keys"
  metric_name         = "KMSKeyPendingDeletionErrorCount"
  namespace           = "CloudTrailLogMetrics"
  datapoints_to_alarm = 1
  treat_missing_data  = "notBreaching"
  statistic           = "SampleCount"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 1
  evaluation_periods  = 1
  period              = 30
}
