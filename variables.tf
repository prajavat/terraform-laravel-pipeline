## 
## Application/Project Variables/Properties
##

variable "region" {
  type        = string
  default     = "us-east-1"
}

variable "stage" {
  type        = string
  default     = "dev"
  description = "Please change as per your environment name"
}

variable "app_name" {
  type        = string
  default     = "example-webapp"
  description = "Please change as per your php/Leavel application name"
}

## 
## EC2 Instance & AutoScaling Group Variables/Properties
##

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 Instance size/type"
}

variable "key_name" {
  type        = string
  default     = ""
  description = "Please change/create EC2 instance PEM key name"
}

variable "desired_capacity" {
  default = "1"
}

variable "min_size" {
  default = "1"
}

variable "max_size" {
  default = "2"
}

## 
## Github Variables/Properties
##

variable "github_auth_token" {
  default = ""
  description = "Please create github auth token"
}

variable "github_user" {
  type        = string
  default     = ""
  description = "Please change Github username"
}

variable "github_repo" {
  type        = string
  default     = ""
  description = "Please change Github repository name"
}

variable "github_branch" {
  type        = string
  default     = "master"
  description = "Please change github repository branch name"
}