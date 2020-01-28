output "ec2_instance_name" {
  value       = module.terraform-aws-ec2.ec2_instance_name
}

output "codedeploy_app_name" {
  value       = module.terraform-aws-code-deploy.codedeploy_app
  description = ""
}

output "codedeploy_deployment_group_id" {
  value       = module.terraform-aws-code-deploy.codedeploy_deployment_group
  description = ""
}