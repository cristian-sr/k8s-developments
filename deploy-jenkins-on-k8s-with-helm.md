# Deploy Jenkins on K8s with Helm

Because helm provide a good deployment control we will use the next steps to get configured Jenkins single instance in our k8s cluster.

Install Jenkins with helm chart

```text
$ helm install --name jenkins stable/jenkins
```

Get admin password

```text
$ printf $(kubectl get secret --namespace default jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
```

Export Url for access via localhost:

```text
$ export SERVICE_IP=$(kubectl get svc --namespace default jenkins --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}”)
```

Access at the link provided via last code line and paste the password that you get.

Enjoy your installation.

