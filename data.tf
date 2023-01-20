data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy" "cw_role_boundary_policy" {
  count = var.put_cw_role_boundary == "" ? 0 : 1
  name  = var.put_cw_role_boundary
}

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
      format("%s:log-stream:*", aws_cloudwatch_log_group.cw_trail_log_group.arn)
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
      variable = "aws:SourceArn"
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
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"
    resources = [
      format("%s/AWSLogs/%s/*",
        aws_s3_bucket.trail_bucket.arn,
        data.aws_caller_identity.current.account_id
      )
    ]
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values = [
        format("arn:aws:cloudtrail:%s:%s:trail/%s",
          data.aws_region.current.name,
          data.aws_caller_identity.current.account_id,
          var.trail_name
        )
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}
