# ==============================================================
# TERRAFORM.TFVARS — Actual runtime values
# Terraform loads this file automatically during plan/apply.
# Values here override the defaults in variables.tf.
# To change the cluster config, just edit values below.
# ==============================================================

aws_region         = "us-west-2"
cluster_name       = "bankapp-eks"
cluster_version    = "1.35"
node_instance_type = "m7i-flex.large"
node_desired_count = 3
node_max_count     = 5
