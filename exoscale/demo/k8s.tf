resource "exoscale_sks_cluster" "c2c" {
  zone          = var.default_zone
  name          = "${var.environment}-cluster"
  service_level = "starter"
}

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
  security_group_id = exoscale_security_group.k8s.id
  description       = "SKS kubelet"
  type              = "INGRESS"
  protocol          = "TCP"
  start_port        = 10250
  end_port          = 10250
}

resource "exoscale_security_group_rule" "calico_traffic" {
  security_group_id = exoscale_security_group.k8s.id
  description       = "Calico traffic"
  type              = "INGRESS"
  protocol          = "UDP"
  start_port        = 4789
  end_port          = 4789
}
