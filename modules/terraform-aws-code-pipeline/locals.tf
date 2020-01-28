locals {
  codepipline_bucket_name = "${var.app_name}-${var.stage}-codepipeline-bucket"
  codepipline_name = "${var.app_name}-${var.stage}-codepipeline"
  codepipline_iam_role_name = "${var.app_name}-${var.stage}-codepipeline-iam-role"
  codepipline_s3_iam_policy_name = "${var.app_name}-${var.stage}-codepipeline-s3-iam-policy"
  codepipline_iam_policy_name = "${var.app_name}-${var.stage}-codepipeline-iam-policy"
}