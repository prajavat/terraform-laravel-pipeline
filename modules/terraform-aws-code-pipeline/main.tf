resource "aws_s3_bucket" "default" {
  bucket        = local.codepipline_bucket_name
  acl           = "private"
  force_destroy = "true"
  tags = {
    Attributes  = "codepipeline"
    Name  = local.codepipline_bucket_name
    Stage = var.stage
  }
}

resource "aws_codepipeline" "default" {
  name     = local.codepipline_name
  role_arn = join("", aws_iam_role.default.*.arn)

  artifact_store {
    location = join("", aws_s3_bucket.default.*.bucket)
    type     = "S3"
  }

  depends_on = [
    aws_iam_role_policy_attachment.default,
    aws_iam_role_policy_attachment.s3
  ]

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["code"]

      configuration = {
        OAuthToken            = var.github_auth_token
        Owner                 = var.github_user
        Repo                  = var.github_repo
        Branch                = var.github_branch
        PollForSourceChanges  = "false"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["code"]
      version         = "1"

      configuration = {
        ApplicationName     = var.codedeploy_name
        DeploymentGroupName = var.codedeploy_group_name
      }
    }
  }
}
