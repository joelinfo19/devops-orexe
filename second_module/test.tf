#variable "region" {
#  description = "AWS region"
#  default     = "eu-central-1"
#}
#
#variable "cluster_name" {
#  description = "EKS cluster name"
#  default     = "my-eks-cluster"
#}
#
#variable "db_username" {
#  description = "RDS username"
#  default     = "admin"
#}
#
#variable "db_password" {
#  description = "RDS password"
#  default     = "password123"
#}
#
#provider "aws" {
#  region = var.region
#}
#
#terraform {
#  backend "s3" {
#    bucket = "eks-labs-terraform-state"
#    key    = "rks-rds/terraform.tfstate"
#    region = "eu-central-1"
#  }
#}
#
#
#data "aws_vpc" "default" {
#  default = true
#}
#
#data "aws_subnets" "default" {
#  filter {
#    name   = "vpc-id"
#    values = [data.aws_vpc.default.id]
#  }
#}
#
#resource "aws_security_group" "eks_nodes" {
#  name        = "eks-nodes-sg"
#  vpc_id      = data.aws_vpc.default.id
#
#  ingress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}
#
#resource "aws_security_group" "rds" {
#  name   = "rds-sg"
#  vpc_id = data.aws_vpc.default.id
#
#  ingress {
#    from_port   = 3306
#    to_port     = 3306
#    protocol    = "tcp"
#    security_groups = [aws_security_group.eks_nodes.id]
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}
#
#resource "aws_eks_cluster" "eks" {
#  name     = var.cluster_name
#  role_arn = aws_iam_role.eks_cluster.arn
#
#  vpc_config {
#    subnet_ids = data.aws_subnets.default.ids
#  }
#
#  depends_on = [aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy]
#}
#
#resource "aws_iam_role" "eks_cluster" {
#  name = "eks-cluster-role"
#
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17",
#    Statement = [{
#      Action = "sts:AssumeRole",
#      Principal = {
#        Service = "eks.amazonaws.com"
#      },
#      Effect = "Allow",
#      Sid = ""
#    }]
#  })
#}
#
#resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#  role       = aws_iam_role.eks_cluster.name
#}
#
#resource "aws_eks_node_group" "node_group" {
#  cluster_name    = aws_eks_cluster.eks.name
#  node_group_name = "eks-node-group"
#  node_role_arn   = aws_iam_role.eks_node_group.arn
#  subnet_ids      = data.aws.default.ids
#
#  scaling_config {
#    desired_size = 2
#    max_size     = 2
#    min_size     = 1
#  }
#}
#
#resource "aws_iam_role" "eks_node_group" {
#  name = "eks-node-group-role"
#
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17",
#    Statement = [{
#      Action = "sts:AssumeRole",
#      Principal = {
#        Service = "ec2.amazonaws.com"
#      },
#      Effect = "Allow",
#      Sid = ""
#    }]
#  })
#}
#
#resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEKSWorkerNodePolicy" {
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#  role       = aws_iam_role.eks_node_group.name
#}
#
#resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEC2ContainerRegistryReadOnly" {
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#  role       = aws_iam_role.eks_node_group.name
#}
#
#resource "aws_db_instance" "default" {
#  allocated_storage    = 20
#  storage_type         = "gp2"
#  engine               = "mysql"
#  engine_version       = "8.0"
#  instance_class       = "db.t3.micro"
#  username             = var.db_username
#  password             = var.db_password
#  parameter_group_name = "default.mysql8.0"
#  skip_final_snapshot  = true
#  vpc_security_group_ids = [aws_security_group.rds.id]
#  db_subnet_group_name = aws_db_subnet_group.default.name
#
#  depends_on = [
#    aws_db_subnet_group.default
#  ]
#
#  tags = {
#    Name = "mydatabase"
#  }
#}
#
#resource "aws_db_subnet_group" "default" {
#  name       = "my-db-subnet-group"
#  subnet_ids = data.aws_subnets.default.ids
#}