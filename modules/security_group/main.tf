data "aws_ip_ranges" "aws_region" {
  regions  = [var.aws_region]
  services = ["cloudfront"]
}

resource "aws_security_group" "elb" {
  vpc_id      = var.vpc_id
  name        = "${var.custom_tags["Name"]}-elb"
  description = "security group that allows web to access app elb"

  dynamic "ingress" {
    for_each = var.elb_ingress

    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      description = ingress.value["description"]
      cidr_blocks = flatten([ingress.value["cidr_blocks"]])
    }
  }

  dynamic "egress" {
    for_each = var.elb_egress

    content {
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      description = egress.value["description"]
      cidr_blocks = flatten([egress.value["cidr_blocks"]])
    }
  }

  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]} ELB" },
  )
}

resource "aws_security_group" "app" {
  vpc_id      = var.vpc_id
  name        = "${var.custom_tags["Name"]}-app"
  description = "security group that allows web to access app elb"

  dynamic "ingress" {
    for_each = var.app_ingress

    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      description = ingress.value["description"]
      cidr_blocks = flatten([ingress.value["cidr_blocks"]])
    }
  }

  dynamic "egress" {
    for_each = var.app_egress

    content {
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      description = egress.value["description"]
      cidr_blocks = flatten([egress.value["cidr_blocks"]])
    }
  }

  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]} APP" },
  )
}

resource "aws_security_group" "db" {
  vpc_id      = var.vpc_id
  name        = "${var.custom_tags["Name"]}-db"
  description = "security group that allows app elb to access app"

  dynamic "ingress" {
    for_each = var.db_ingress

    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      description = ingress.value["description"]
      cidr_blocks = flatten([ingress.value["cidr_blocks"]])
    }
  }

  dynamic "egress" {
    for_each = var.db_egress

    content {
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      description = egress.value["description"]
      cidr_blocks = flatten([egress.value["cidr_blocks"]])
    }
  }

  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]} DB" },
  )
}

resource "aws_security_group" "elasticache" {
  vpc_id      = var.vpc_id
  name        = "${var.custom_tags["Name"]}-elasticache"
  description = "security group that manage access to elasticache"

  dynamic "ingress" {
    for_each = var.elasticache_ingress

    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      description = ingress.value["description"]
      cidr_blocks = flatten([ingress.value["cidr_blocks"]])
    }
  }

  dynamic "egress" {
    for_each = var.elasticache_egress

    content {
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      description = egress.value["description"]
      cidr_blocks = flatten([egress.value["cidr_blocks"]])
    }
  }

  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]} ElastiCache" },
  )
}

resource "aws_security_group" "cloudfront" {
  vpc_id      = var.vpc_id
  name        = "${var.custom_tags["Name"]}-CloudFront"
  description = "security group that allows Any to cloudfront with https"

  dynamic "ingress" {
    for_each = var.cloud_front_ingress

    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      description = ingress.value["description"]
      cidr_blocks = flatten([ingress.value["cidr_blocks"]])
    }
  }

  dynamic "egress" {
    for_each = var.cloud_front_egress

    content {
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      description = egress.value["description"]
      cidr_blocks = flatten([egress.value["cidr_blocks"]])
    }
  }

  tags = merge(
    var.default_tags,
    var.custom_tags,
    { "Name" = "${var.custom_tags["Name"]} CloudFront" },
  )
}
