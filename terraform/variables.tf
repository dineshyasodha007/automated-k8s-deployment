variable "aws_region" {
  description = "AWS region to create the EKS cluster"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "demo-eks-cluster"
}

variable "node_instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "Number of worker nodes"
  default     = 2
}
