resource "exoscale_sks_cluster" "c2c" {
  zone          = var.default_zone
  name          = "${var.environment}-cluster"
  service_level = "starter"
}

resource "exoscale_sks_kubeconfig" "c2c" {
  cluster_id = exoscale_sks_cluster.c2c.id
  zone       = exoscale_sks_cluster.c2c.zone
  user       = "kubernetes-admin"
  groups     = ["system:masters"]
}

resource "exoscale_sks_nodepool" "pool1" {
  cluster_id         = exoscale_sks_cluster.c2c.id
  zone               = exoscale_sks_cluster.c2c.zone
  name               = "${var.environment}-nodepool1"
  instance_prefix    = "${var.environment}-nodepool1"
  security_group_ids = [exoscale_security_group.k8s.id]
  instance_type      = "standard.small"
  size               = 1
}
# resource "exoscale_sks_nodepool" "pool2" {
#   cluster_id         = exoscale_sks_cluster.c2c.id
#   zone               = exoscale_sks_cluster.c2c.zone
#   name               = "${var.environment}-nodepool2"
#   instance_prefix    = "${var.environment}-nodepool2"
#   security_group_ids = [exoscale_security_group.k8s.id]
#   instance_type      = "standard.small"
#   size               = 1
# }

resource "exoscale_security_group" "k8s" {
  name = "${var.environment}-cluster-security-group"
}

resource "exoscale_security_group_rule" "nodeport_services" {
  security_group_id = exoscale_security_group.k8s.id
  description       = "NodePort services"
  type              = "INGRESS"
  protocol          = "TCP"
  cidr              = "0.0.0.0/0"
  start_port        = 30000
  end_port          = 32767
}

resource "exoscale_security_group_rule" "kubelet" {
  security_group_id      = exoscale_security_group.k8s.id
  description            = "SKS kubelet"
  type                   = "INGRESS"
  protocol               = "TCP"
  user_security_group_id = exoscale_security_group.k8s.id
  start_port             = 10250
  end_port               = 10250
}

resource "exoscale_security_group_rule" "calico_traffic" {
  security_group_id      = exoscale_security_group.k8s.id
  description            = "Calico traffic"
  type                   = "INGRESS"
  protocol               = "UDP"
  user_security_group_id = exoscale_security_group.k8s.id
  start_port             = 4789
  end_port               = 4789
}
