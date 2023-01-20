resource "aws_cloudwatch_log_group" "trail_log_group" {
  name = var.cw_log_group_name
  tags = var.tags
}

resource "aws_cloudwatch_log_stream" "trail_log_stream" {
  name           = var.cw_log_group_name
  log_group_name = aws_cloudwatch_log_group.trail_log_group.name
}
