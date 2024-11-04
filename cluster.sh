#!/bin/bash

kind create cluster

kind get clusters

kubectl get no


cat kind-config

kind create cluster --name=multi-node-cluster --config=kind-config


kubectl get no

kind get clusters

kind delete cluster --name=kind 

cat kind-ingress-config


kind create cluster --name=ingress-cluster --config=kind-ingress-config

kind get clusters

kubectl get no

kubectl apply -f configmap-secret.yml


kubectl get configmaps
kubectl get secrets
