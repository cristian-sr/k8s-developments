---
description: How to configure helm in our k8s cluster
---

# Helm on K8S

Para MAC-OS 

```text
$ brew install kubernetes-helm
```

Now create a service account and a cluster role binding for Tiller:

```text
kubectl -n kube-system create sa tiller

kubectl create clusterrolebinding tiller-cluster-rule \
    --clusterrole=cluster-admin \
    --serviceaccount=kube-system:tiller
```

Deploy Tiller in `kube-system` namespace:

```text
helm init --skip-refresh --upgrade --service-account tiller --history-max 10
```

