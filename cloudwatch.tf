# Create the log group where CloudTrail will send the logs
resource "aws_cloudwatch_log_group" "cw_trail_log_group" {
  name = var.cw_log_group_name
  tags = var.tags
}

# Create a custom metric based on filtering KMS events
resource "aws_cloudwatch_log_metric_filter" "cw_kms_use_deleted_key_filter" {
  name           = var.cw_log_metric_filter_name
  pattern        = "{ $.eventSource = kms* && $.errorMessage = \"* is pending deletion.\"}"
  log_group_name = aws_cloudwatch_log_group.cw_trail_log_group.name

  metric_transformation {
    name      = var.cw_custom_metric_name
    namespace = var.cw_custom_metric_namespace
    value     = "1"
  }
}

# Create a CloudWatch alarm based on the custom metric
resource "aws_cloudwatch_metric_alarm" "cw_kms_use_deleted_key_alarm" {
  alarm_name          = var.cw_alarm_name
  alarm_description   = "This metric monitors usage of pending deletion KMS keys"
  metric_name         = var.cw_custom_metric_name
  namespace           = var.cw_custom_metric_namespace
  datapoints_to_alarm = 1
  treat_missing_data  = "notBreaching"
  statistic           = "SampleCount"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 1
  evaluation_periods  = 1
  period              = 10
  alarm_actions       = [aws_sns_topic.cw_kms_use_deleted_key_alarm_topic.arn]
  tags                = var.tags
}
