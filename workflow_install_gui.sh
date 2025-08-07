kubectl create ns argo
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.6.10/install.yaml
kubectl -n argo get deploy workflow-controller
kubectl -n argo get deploy workflow-controller
kubectl -n argo wait deploy --all --for condition=Available --timeout 2m
kubectl create serviceaccount argo-workflow -n argo



kubectl patch deployment \
  argo-server \
  --namespace argo \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
  "server",
  "--auth-mode=server",
  "--secure=false"
]},
{"op": "replace", "path": "/spec/template/spec/containers/0/readinessProbe/httpGet/scheme", "value": "HTTP"}
]'

kubectl -n argo rollout status --watch --timeout=600s deployment/argo-server
kubectl -n argo port-forward --address 0.0.0.0 svc/argo-server 2746:2746 > /dev/null &
