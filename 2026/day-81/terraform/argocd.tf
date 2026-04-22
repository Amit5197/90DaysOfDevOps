# ==============================================================
# ArgoCD — Installed via Helm into the EKS cluster
# Exposed via LoadBalancer (accessible in browser)
# server.insecure = true disables HTTPS (OK for lab, not production)
# depends_on ensures cluster exists before installing
# ==============================================================

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  values = [
    yamlencode({
      server = {
        service = {
          type = "LoadBalancer"
        }
      }
      configs = {
        params = {
          "server.insecure" = true
        }
      }
    })
  ]

  depends_on = [module.eks]
}
