############### Creating ECS Cluster ###############

resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${local.env_name}-${local.client}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = local.common_tags
}