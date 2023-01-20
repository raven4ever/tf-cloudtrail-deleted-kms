resource "aws_cloudtrail" "kms_trail" {
  name                          = var.trail_name
  s3_bucket_name                = aws_s3_bucket.trail_bucket.id
  enable_log_file_validation    = true
  include_global_service_events = true
  cloud_watch_logs_group_arn    = format("%s:*", aws_cloudwatch_log_group.trail_log_group.arn)
  cloud_watch_logs_role_arn     = aws_iam_role.put_cw_role.arn
  tags                          = var.tags

  depends_on = [
    aws_s3_bucket_policy.trail_bucket_policy
  ]
}
