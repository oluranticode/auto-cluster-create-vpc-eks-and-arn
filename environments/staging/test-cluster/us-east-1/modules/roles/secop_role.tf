# resource "kubernetes_manifest" "secops_crb" {
#   manifest = yamldecode(file("${path.module}/auth/secops-crb.yaml"))
# }
# resource "kubernetes_manifest" "secops_role" {
#   manifest = yamldecode(file("${path.module}/auth/secops-role.yaml"))

# # }


terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

resource "kubectl_manifest" "secops_crb" {
  yaml_body = <<YAML
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
      name: secops-admin
    subjects:
    - kind: Group
      name: secops-admin
      apiGroup: rbac.authorization.k8s.io
    roleRef:
      kind: ClusterRole
      name: view
      apiGroup: rbac.authorization.k8s.io
YAML
}

resource "kubectl_manifest" "secops_role" {
  yaml_body = <<YAML
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRole
  metadata:
    name: viewing-nodes
    labels:
      rbac.authorization.k8s.io/aggregate-to-view: "true"
  rules:
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["get", "list", "watch"]
YAML
}
