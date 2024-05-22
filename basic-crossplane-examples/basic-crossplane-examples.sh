#!/bin/bash

kubectl apply -f basic-crossplane-examples/rbac.yaml

kubectl apply -f basic-crossplane-examples/provider.yaml

kubectl apply -f basic-crossplane-examples/xrd.yaml

kubectl apply -f basic-crossplane-examples/composition.yaml

kubectl apply -f basic-crossplane-examples/claim.yaml