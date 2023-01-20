resource "aws_iam_role" "put_cw_role" {
  name               = var.put_cw_role_name
  assume_role_policy = data.aws_iam_policy_document.cw_role_assume_policy.json
  tags               = var.tags
}

resource "aws_iam_role_policy" "put_cw_role_policy" {
  name_prefix = format("%s-policy", var.put_cw_role_name)
  role        = aws_iam_role.put_cw_role.id
  policy      = data.aws_iam_policy_document.cw_role_permissions_policy.json
}