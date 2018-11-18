variable "vpc" {
  description = "VPC ID where to launch ElasticSearch cluster"
}

variable "vpc_cidr" {
  description = "CIDR to allow connections to ElasticSearch"
}

variable "region" {
  description = "AWS region to use"
}

variable "es_domain" {
  description = "ElasticSearch domain name"
}

variable "es_subnets" {
  type = "list"
  description = "List of VPC Subnet IDs to create ElasticSearch Endpoints in"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = "${var.region}"
}

resource "aws_security_group" "es_sg" {
  name = "${var.es_domain}-sg"
  description = "Allow inbound traffic to ElasticSearch from VPC CIDR"
  vpc_id = "${var.vpc}"

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [
          "${var.vpc_cidr}"
      ]
  }
}

resource "aws_elasticsearch_domain" "es" {
  domain_name = "${var.es_domain}"
  elasticsearch_version = "6.3"

  cluster_config {
      instance_type = "r4.large.elasticsearch"
  }

  vpc_options {
      subnet_ids = "${var.es_subnets}"
      security_group_ids = [
          "${aws_security_group.es_sg.id}"
      ]
  }

  ebs_options {
      ebs_enabled = true
      volume_size = 10
  }

  access_policies = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": "es:*",
          "Principal": "*",
          "Effect": "Allow",
          "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.es_domain}/*"
      }
  ]
}
  CONFIG

  snapshot_options {
      automated_snapshot_start_hour = 23
  }

  tags {
      Domain = "${var.es_domain}"
  }
}

output "ElasticSearch Endpoint" {
  value = "${aws_elasticsearch_domain.es.endpoint}"
}

output "ElasticSearch Kibana Endpoint" {
  value = "${aws_elasticsearch_domain.es.kibana_endpoint}"
}

