resource "aws_cloudwatch_log_group" "trail_log_group" {
  name = var.cw_log_group_name
  tags = var.tags
}

resource "aws_cloudwatch_log_stream" "trail_log_stream" {
  name           = var.cw_log_group_name
  log_group_name = aws_cloudwatch_log_group.trail_log_group.name
}

resource "aws_cloudwatch_log_metric_filter" "kms_trail_filter" {
  name           = var.cw_log_metric_filter_name
  pattern        = "{ $.eventSource = kms* && $.errorMessage = \"* is pending deletion.\"}"
  log_group_name = aws_cloudwatch_log_group.trail_log_group.name

  metric_transformation {
    name      = "EventCount"
    namespace = "CustomNamespace"
    value     = "1"
    unit      = "None"
  }
}
