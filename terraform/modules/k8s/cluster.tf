resource "scaleway_k8s_cluster" "arcons-k8s" {
  name = "arcons-k8s"
  version = "1.20.7"
  cni = "calico"
  autoscaler_config {
    scale_down_unneeded_time      = "5m"
    ignore_daemonsets_utilization = true
  }
}

resource "scaleway_k8s_pool" "pool-containerd" {
  cluster_id        = scaleway_k8s_cluster.arcons-k8s.id
  name              = "pool-ctd"
  container_runtime = "containerd"
  node_type         = "GP1-XS"
  size              = 3
  autoscaling       = true
  autohealing       = true
  min_size          = 3
  max_size          = 5
}

resource "local_file" "kubeconfig" {
  content = scaleway_k8s_cluster.arcons-k8s.kubeconfig[0].config_file
  filename = "${path.module}/kubeconfig"
}