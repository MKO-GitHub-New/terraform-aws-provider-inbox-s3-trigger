data "aws_iam_policy_document" "tsh_test_provider_inbox" {
  statement {
    actions = [
      "s3:ListBucket"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${local.tsh_test_provider_inbox_bucket_name}"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/marichka"]
    }

    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values = [
        "decisionsource_uat/*",
        "decisionsource_prod/*"
      ]
    }
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${local.tsh_test_provider_inbox_bucket_name}/decisionsource_uat/*",
      "arn:aws:s3:::${local.tsh_test_provider_inbox_bucket_name}/decisionsource_prod/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/marichka"]
    }
  }
}