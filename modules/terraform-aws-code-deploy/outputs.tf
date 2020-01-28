output "codedeploy_app" {
  value       = aws_codedeploy_app.main.name
}

output "codedeploy_deployment_group" {
  value       = aws_codedeploy_deployment_group.main.deployment_group_name
}