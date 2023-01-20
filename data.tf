data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}

data "aws_iam_policy_document" "cw_role_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "cw_role_permissions_policy" {
  statement {
    effect  = "Allow"
    actions = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = [
      format("arn:%s:logs:%s:%s:log-group:%s:log-stream:*",
        data.aws_partition.current.partition,
        data.aws_region.current.name,
        data.aws_caller_identity.current.account_id,
        aws_cloudwatch_log_group.trail_log_group.name
      )
    ]
  }
}

data "aws_iam_policy_document" "cloudtrail_bucket_policy_document" {
  statement {
    sid       = "AWSCloudTrailAclCheck"
    effect    = "Allow"
    resources = [aws_s3_bucket.trail_bucket.arn]
    actions   = ["s3:GetBucketAcl"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values = [
        format("arn:aws:cloudtrail:%s:%s:trail/%s",
          data.aws_region.current.name,
          data.aws_caller_identity.current.account_id,
          var.trail_name
        )
      ]
    }
  }
  statement {
    sid       = "AWSCloudTrailWrite"
    effect    = "Allow"
    resources = [aws_s3_bucket.trail_bucket.arn]
    actions   = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values = [
        format("arn:aws:cloudtrail:%s:%s:trail/%s",
          data.aws_region.current.name,
          data.aws_caller_identity.current.account_id,
          var.trail_name
        )
      ]
    }
  }
}
