#
# Container Instance IAM resources
#
data "aws_iam_policy_document" "ec2_instance_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2_instance" {
  name               = local.ec2_role_name
  assume_role_policy = data.aws_iam_policy_document.ec2_instance_assume_role.json
}

resource "aws_iam_role_policy_attachment" "ec2_service_role" {
  role       = aws_iam_role.ec2_instance.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

resource "aws_iam_instance_profile" "ec2_instance" {
  name = aws_iam_role.ec2_instance.name
  role = aws_iam_role.ec2_instance.name
}


data "template_file" "ec2_instance_base_cloud_config" {
  template = file("${path.module}/cloud-config/ec2-instance.sh.tpl")

  vars = {
    region  = var.region
  }  
}

data "template_cloudinit_config" "ec2_instance_cloud_config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.ec2_instance_base_cloud_config.rendered
  }

}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

resource "aws_launch_template" "ec2_instance" {
  name  = local.lunch_template_name

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_termination = false

  
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance.name
  }

  image_id = data.aws_ami.amazon_linux.id

  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance_type
  key_name                             = var.key_name
  vpc_security_group_ids               = [aws_security_group.ec2_instance.id]
  user_data                            = base64encode(data.template_cloudinit_config.ec2_instance_cloud_config.rendered)

}

resource "aws_autoscaling_group" "ec2_instance" {
  lifecycle {
    create_before_destroy = true
  }

  name = local.autoscaling_group_name

  launch_template {
    id = aws_launch_template.ec2_instance.id
    version = "$Latest"
  }

  health_check_grace_period = "60"
  health_check_type         = "EC2"
  desired_capacity          = var.desired_capacity
  termination_policies      = ["OldestLaunchConfiguration", "Default"]
  min_size                  = var.min_size
  max_size                  = var.max_size

  enabled_metrics = [
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupMaxSize",
    "GroupMinSize",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  vpc_zone_identifier       = module.main-vpc.public_subnets

  tag {
    key                 = "Name"
    value               = local.instance_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.app_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.stage
    propagate_at_launch = true
  }
}