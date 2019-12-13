module "provision_external_dns" {
  source     = "../kubectl-apply"
  kubeconfig = "${path.root}/${var.name}.kubeconfig"

  apply = var.external_dns

  template = file("${path.module}/cluster_configs/external-dns.tpl.yaml")

  vars = {
    wait_for_eks = null_resource.wait_for_eks.id
    domain_filters = length(var.external_dns_domain_filters) > 0 ? "- --domain-filter=${join(
      "\n        - --domain-filter=",
      var.external_dns_domain_filters,
    )}" : ""
  }
}

