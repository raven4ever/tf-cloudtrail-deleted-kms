resource "aws_sns_topic" "cw_kms_use_deleted_key_alarm_topic" {
  name = var.sns_topic_name
  tags = var.tags
}

resource "aws_sns_topic_subscription" "cw_kms_use_deleted_key_subs" {
  for_each  = var.sns_subscription_emails
  endpoint  = each.value
  protocol  = "email"
  topic_arn = aws_sns_topic.cw_kms_use_deleted_key_alarm_topic.arn
}
