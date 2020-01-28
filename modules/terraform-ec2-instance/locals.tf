locals {
    ec2_role_name = "${var.app_name}-${var.stage}-ec2-service-role"
    security_group_name = "${var.app_name}-${var.stage}-security-group"
    vpc_name = "${var.app_name}-${var.stage}-vpc"
    lunch_template_name = "${var.app_name}-${var.stage}-template"
    autoscaling_group_name = "${var.app_name}-${var.stage}-ag"
    instance_name = "${var.app_name}-${var.stage}-instance"
}