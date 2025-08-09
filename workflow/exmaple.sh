kubectl -n argo apply -f hello-workflow.yaml
kubectl -n argo wait workflows/hello --for condition=Completed --timeout 2m
