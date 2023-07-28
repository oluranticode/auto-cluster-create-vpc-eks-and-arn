resource "helm_release" "ingress_nginx" {
  count = var.install_ingress_nginx ? 1 : 0
  depends_on = [
    var.cluster_name
  ]
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  version          = "4.6.0"
  namespace        = "nginx"
  reuse_values     = true
  cleanup_on_fail  = true
  create_namespace = true
  values = [
    templatefile(
      "${path.module}/manifests/nginx.yaml",
      {
        acm_certificate_arn = aws_acm_certificate.acm_cert.arn
      }
    )
  ]
}