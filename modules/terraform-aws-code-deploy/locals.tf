locals {
  codedeploy_iam_role = "${var.app_name}-${var.stage}-codedeploy-service-role"
  codedeploy_name = "${var.app_name}-${var.stage}-codedeploy"
  codedeploy_group_name = "${var.app_name}-${var.stage}-codedeploy-group"
}