 kubectl create serviceaccount argo-workflow -n argo
 
 cat <<EOF1 | kubectl apply -f - >/dev/null
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: workflow-executor-rbac
rules:
  - apiGroups:
      - argoproj.io
    resources:
      - workflowtaskresults
    verbs:
      - create
      - patch
EOF1

cat <<EOF2 | kubectl apply -f - >/dev/null
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: argo-executor-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: workflow-executor-rbac
subjects:
- kind: ServiceAccount
  name: argo-workflow
  namespace: argo
EOF2
