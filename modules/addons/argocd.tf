terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "15.8.0"
    }
  }
}

resource "helm_release" "argocd" {
  count = var.install_argocd ? 1 : 0
  depends_on = [
    var.cluster_name
  ]
  name             = "argocd"
  chart            = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  version          = "5.17.4"
  namespace        = "argocd"
  reuse_values     = true
  max_history      = 5
  cleanup_on_fail  = true
  create_namespace = true
  values = [
    templatefile(
      "${path.module}/manifests/argocd.yaml",
      {
        jumpcloud_clientsecret       = data.gitlab_project_variable.jumpcloud_clientsecret.value
        argocd_gat                   = data.gitlab_group_variable.argocd_gat.value
        argocd-gitlab-webhook-secret = jsondecode(data.aws_secretsmanager_secret_version.argocd-gitlab-webhook-secret.secret_string)["argocd-gitlab-webhook-secret"]
        slack-token                  = jsondecode(data.aws_secretsmanager_secret_version.slack-token.secret_string)["slack-token"]
      }
    )
  ]
}

data "gitlab_group_variable" "argocd_gat" {
  group = "2813672"
  key   = "argocd_gat"
}

data "gitlab_project_variable" "jumpcloud_clientsecret" {
  project = "33471778"
  key     = "jumpcloud_clientsecret"
}

data "aws_secretsmanager_secret" "argocd-gitlab-webhook-secret" {
  name = "devops/argocd-gitlab-webhook-secret"
}

data "aws_secretsmanager_secret_version" "argocd-gitlab-webhook-secret" {
  secret_id = data.aws_secretsmanager_secret.argocd-gitlab-webhook-secret.id
}

data "aws_secretsmanager_secret" "slack-token" {
  name = "devops/argocd-slack-token"
}

data "aws_secretsmanager_secret_version" "slack-token" {
  secret_id = data.aws_secretsmanager_secret.slack-token.id
}

resource "kubernetes_manifest" "acquire-cluster-appset" {
  depends_on = [
    helm_release.argocd
  ]
  manifest = yamldecode(file("${path.module}/manifests/argocd-appsets/acquire-cluster-appset.yaml"))
}

resource "kubernetes_manifest" "core-cluster-appset" {
  depends_on = [
    helm_release.argocd
  ]
  manifest = yamldecode(file("${path.module}/manifests/argocd-appsets/core-cluster-appset.yaml"))
}

resource "kubernetes_manifest" "dev-cluster-appset" {
  depends_on = [
    helm_release.argocd
  ]
  manifest = yamldecode(file("${path.module}/manifests/argocd-appsets/dev-cluster-appset.yaml"))
}

resource "kubernetes_manifest" "f4b-cluster-appset" {
  depends_on = [
    helm_release.argocd
  ]
  manifest = yamldecode(file("${path.module}/manifests/argocd-appsets/f4b-cluster-appset.yaml"))
}

resource "kubernetes_manifest" "generic-appset" {
  depends_on = [
    helm_release.argocd
  ]
  manifest = yamldecode(file("${path.module}/manifests/argocd-appsets/generic-appset.yaml"))
}

resource "kubernetes_manifest" "platform-service-appset-preprod" {
  depends_on = [
    helm_release.argocd
  ]
  manifest = yamldecode(file("${path.module}/manifests/argocd-appsets/platform-service-appset-preprod.yaml"))
}

resource "kubernetes_manifest" "platform-service-appset-prod" {
  depends_on = [
    helm_release.argocd
  ]
  manifest = yamldecode(file("${path.module}/manifests/argocd-appsets/platform-service-appset-prod.yaml"))
}

resource "kubernetes_manifest" "flw-auto-cluster-appset" {
  depends_on = [
    helm_release.argocd
  ]
  manifest = yamldecode(file("${path.module}/manifests/argocd-appsets/flw-auto-cluster-appset.yaml"))
}