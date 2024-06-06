kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sleep 30

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

kubectl create ns django-docker

kubectl apply -f application.yaml

kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null &

open http://localhost:8080

argocd admin initial-password -n argocd

sleep 30

kubectl port-forward svc/django-service 8000:8000 -n django-docker > /dev/null &

open http://localhost:8000/hello