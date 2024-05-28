# Crossplane Prep

## What is crossplane?

Crossplane serves as an open-source Kubernetes extension that broadens the Kubernetes API's capabilities by facilitating the provisioning and administration of cloud infrastructure and services. In essence, it establishes a "control plane" for cloud assets within Kubernetes, enabling users to specify and oversee infrastructure through code. Control planes oversee resource lifecycles, consistently verifying the existence of intended resources, alerting when actual states deviate from expectations, and taking corrective actions as necessary. With Crossplane, users can define custom resources representing various cloud infrastructure elements like databases, storage containers, virtual machines, or managed services such as AWS RDS or Google Cloud Pub/Sub. These custom resources are then translated into practical steps to provision and manage the corresponding resources within the designated cloud provider.

## Providers:

Providers empower Crossplane to orchestrate infrastructure provisioning on external services.
They handle all facets of interfacing with non-Kubernetes resources, encompassing authentication, executing external API requests, and furnishing Kubernetes Controller logic for external resources.
Providers diligently monitor the status of managed resources to ensure alignment with desired configurations, promptly generating any absent external resources as needed.

## Managed Resources:

A managed resource (MR) within a Provider signifies an external service. Upon users' creation of a new managed resource, the Provider responds by generating a corresponding external resource within its environment. Each external service overseen by Crossplane corresponds to a managed resource.

## Composition:

Compositions serve as a blueprint for generating numerous managed resources as a unified entity.
By amalgamating individual managed resources, a Composition constructs a comprehensive and reusable solution.
This may entail amalgamating elements like virtual machines, storage resources, and networking policies, all interconnected within a Composition template.

## Composition Revisions

"Composition Revisions" aids in crafting and reverting modifications to a Crossplane Composition.

## Composite Resource Definitions

Composite Resource Definitions (XRDs) outline the schema for a tailored API.
Utilizing the API schema laid out by an XRD, users generate Composite Resources (XRs) and Claims (XCs).

## Composite Resource:

A composite resource consolidates a collection of managed resources into a singular Kubernetes entity. Crossplane generates composite resources upon users' interaction with a bespoke API, delineated in the CompositeResourceDefinition.

`Important Note`:

Producing composite resources necessitates both a Composition and a CompositeResourceDefinition (XRD).
The Composition outlines the assortment of resources to be generated.
The XRD delineates the custom API that users invoke to solicit the assortment of resources.

## Claims

Claims epitomize a grouping of managed resources encapsulated within a singular Kubernetes object, situated within a namespace. Users instantiate claims upon accessing the bespoke API outlined in the CompositeResourceDefinition.

Testkube install:

testkube init

Argocd :

# argocd-app-of-app-test# Argocd App of Apps patterns, using the basic approach

Basic way to set-up argocd.

## Create an argocd namespace in your cluster

```
kubectl create namespace argocd
```

## Install argocd in your cluster

```
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## Monitor progress of argocd pod creation

```
kubectl get pods -n argocd --watch
```

## Download argocd onto your machine:

[download guide](https://argo-cd.readthedocs.io/en/stable/getting_started/#2-download-argo-cd-cli)

```
brew install argocd
```

## Forward a port from your local machine to the pod running the argocd-server

```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

## Get the admin password, to allow you to sign-in into the argo-ui

```
argocd admin initial-password -n argocd
```

## Open the argo ui

https://localhost:8080

## Login to argo on the cli:

```
argocd login localhost:8080
```


Crossplane installation:

```
helm repo add crossplane-stable https://charts.crossplane.io/stable
```

```
helm repo update
```

```
helm install crossplane \
--namespace crossplane-system \
--create-namespace crossplane-stable/crossplane 
```

Provider Installation:

crossplane xpkg install provider xpkg.upbound.io/crossplane-contrib/provider-kubernetes:v0.13.0

Komoplane installation:

helm repo add komodorio https://helm-charts.komodor.io \
  && helm repo update komodorio \
  && helm upgrade --install komoplane komodorio/komoplane

Port forward:

kubectl port-forward svc/komoplane 8090:8090 

Crossplane Config script:

kubectl apply -f crossplane-composite-config/rbac.yaml

kubectl apply -f crossplane-composite-config/provider.yaml