module "terraform-aws-ec2" {
  source            = "./modules/terraform-ec2-instance"
  stage             = var.stage
  app_name          = var.app_name
  region            = var.region
  instance_type     = var.instance_type
  key_name          = var.key_name
  desired_capacity  = var.desired_capacity
  min_size          = var.min_size
  max_size          = var.max_size
}

module "terraform-aws-code-deploy" {
  source            = "./modules/terraform-aws-code-deploy"
  stage             = var.stage
  app_name          = var.app_name
  ec2_name          = module.terraform-aws-ec2.ec2_instance_name
}

module "terraform-aws-code-pipeline" {
  source                = "./modules/terraform-aws-code-pipeline"
  stage                 = var.stage
  app_name              = var.app_name
  codedeploy_name       = module.terraform-aws-code-deploy.codedeploy_app
  codedeploy_group_name = module.terraform-aws-code-deploy.codedeploy_deployment_group
  github_auth_token     = var.github_auth_token
  github_user           = var.github_user
  github_repo           = var.github_repo
  github_branch         = var.github_branch
}


module "terraform-aws-code-pipeline" {
  source                = "./modules/terraform-aws-code-pipeline"
  stage                 = var.stage
  app_name              = var.app_name
  codedeploy_name       = module.terraform-aws-code-deploy.codedeploy_app
  codedeploy_group_name = module.terraform-aws-code-deploy.codedeploy_deployment_group
  github_auth_token     = var.github_auth_token
  github_user           = var.github_user
  github_repo           = var.github_repo
  github_branch         = var.github_branch
}

module "terraform-aws-code-pipeline" {
  source                = "./modules/terraform-aws-code-pipeline"
  stage                 = var.stage
  app_name              = var.app_name
  codedeploy_name       = module.terraform-aws-code-deploy.codedeploy_app
  codedeploy_group_name = module.terraform-aws-code-deploy.codedeploy_deployment_group
  github_auth_token     = var.github_auth_token
  github_user           = var.github_user
  github_repo           = var.github_repo
  github_branch         = var.github_branch
}

module "terraform-aws-code-pipeline" {
  source                = "./modules/terraform-aws-code-pipeline"
  stage                 = var.stage
  app_name              = var.app_name
  codedeploy_name       = module.terraform-aws-code-deploy.codedeploy_app
  codedeploy_group_name = module.terraform-aws-code-deploy.codedeploy_deployment_group
  github_auth_token     = var.github_auth_token
  github_user           = var.github_user
  github_repo           = var.github_repo
  github_branch         = var.github_branch
}