# Ddoksik Infra

This repository contains the infrastructure as code (IaC) configurations for the Ddoksik project. It uses **Terraform** for provisioning AWS resources, **Kubernetes** for deploying and managing microservices, **ArgoCD** for GitOps-based continuous delivery, and **Karpenter** for automated Kubernetes cluster scaling. Additionally, the repository includes monitoring, logging, and auto-scaling configurations using **Prometheus**, **Grafana**, **Fluentbit**, and **OpenSearch**.

## Table of Contents

- [Overview](#overview)
- [Technologies Used](#technologies-used)
- [Infrastructure Components](#infrastructure-components)
- [Installation](#installation)
- [Usage](#usage)
- [Monitoring and Logging](#monitoring-and-logging)
- [Contributing](#contributing)
- [License](#license)

## Overview

This repository manages the entire infrastructure for the Ddoksik project. It is divided into multiple directories for different purposes such as handling Horizontal Pod Autoscaling (HPA), managing Kubernetes resources with **ArgoCD**, and configuring **Karpenter** for autoscaling. The repository also includes scripts and configurations for monitoring, logging, and handling serverless architecture with **AWS Lambda**.

## Technologies Used

- **Terraform**: Used for managing and provisioning AWS resources.
- **Kubernetes**: Container orchestration for running microservices.
- **ArgoCD**: GitOps-based continuous delivery tool for Kubernetes.
- **Karpenter**: Kubernetes cluster autoscaler for managing node provisioning.
- **Prometheus** & **Grafana**: Monitoring and alerting.
- **Fluentbit** & **OpenSearch**: Centralized logging and log forwarding.
- **Jaeger**: Distributed tracing for microservices.
- **AWS Lambda**: For serverless execution of certain tasks.

## Infrastructure Components

### HPA (Horizontal Pod Autoscaling)
The `HPA` directory contains configuration for autoscaling the diet, user, and UI services based on CPU and memory utilization.

- **diet-hpa.tf**: Terraform configuration for the diet service autoscaler.
- **user-hpa.tf**: Terraform configuration for the user service autoscaler.
- **ui-hpa.tf**: Terraform configuration for the UI service autoscaler.
- **metrics-server.yaml**: Deploys the Kubernetes Metrics Server, a necessary component for HPA.

### ArgoCD
The `argocd` directory manages the continuous deployment of Kubernetes resources.

- **argocd-ingress.yaml**: Ingress configuration for ArgoCD.
- **argocd-svc.yaml**: Service configuration for ArgoCD.

### Karpenter
The `karpenter` directory contains Terraform scripts to enable Karpenter, which handles Kubernetes node scaling.

- **karpenter.tf**: Terraform configuration for Karpenter setup.
- **providers.tf**: Provider configurations for AWS and Kubernetes.

### Logs
The `logs` directory handles centralized logging using Fluentbit and OpenSearch.

- **fluentbit+OpenSearch**: Fluentbit configuration to forward logs to OpenSearch for centralized logging and analysis.
- **s3-to-opensearch**: Lambda function code that moves data from an S3 bucket to OpenSearch.

### Monitoring
The `monitoring` directory includes configurations for monitoring services using Prometheus and Grafana.

- **grafana.yaml**: Grafana deployment configuration.
- **prometheus/alertmanager**: Prometheus Alertmanager configuration for handling alerts.
- **prometheus/kube-state-metrics**: Monitors the state of Kubernetes objects.
- **prometheus/prometheus-node-exporter**: Exposes system-level metrics for Prometheus.
- **prometheus/prometheus-pushgateway**: For pushing metrics to Prometheus.

## Installation

### Prerequisites

- **Terraform**: Ensure that Terraform is installed (`>= 1.0.0`).
- **kubectl**: Kubernetes CLI to interact with the cluster.
- **AWS CLI**: For authentication with AWS services.
- **Helm**: For deploying Prometheus and Grafana.

### Cloning the Repository

```bash
git clone https://github.com/seungjun-Lee0/ddoksik-infra.git
cd ddoksik-infra
```

Initialize and Apply Terraform
To set up the infrastructure, use Terraform to initialize and apply the configurations:

```bash
terraform init
terraform apply
```
Make sure to have the necessary AWS credentials and permissions to manage the resources.

Deploying Kubernetes Resources
Once the infrastructure is provisioned, deploy the Kubernetes resources using the following commands:

```bash
kubectl apply -f argocd/argocd-ingress.yaml
kubectl apply -f argocd/argocd-svc.yaml
kubectl apply -f HPA/metrics-server.yaml
```
Usage
Scaling with Karpenter
Karpenter automatically provisions new nodes in response to pending pods in your Kubernetes cluster. To check Karpenter logs and scaling activities, use:

```bash
kubectl logs -n karpenter -l karpenter
```
Monitoring with Prometheus and Grafana
Prometheus scrapes metrics from various Kubernetes components, and Grafana provides visual dashboards. To access the Grafana UI, configure the Ingress (grafana-Ingress.yaml) and forward the port:

```bash
kubectl port-forward svc/grafana 3000:80
```
Access Grafana at http://localhost:3000 and log in using the default credentials.

Monitoring and Logging
Centralized Logging with Fluentbit and OpenSearch
The logging solution uses Fluentbit to collect logs from Kubernetes pods and forward them to OpenSearch for centralized storage and analysis. To deploy the logging components:

```bash
kubectl apply -f logs/fluentbit+OpenSearch/
```
You can view logs in OpenSearch and set up dashboards for detailed log analysis.

Distributed Tracing with Jaeger
The jaeger.yaml file deploys Jaeger, a distributed tracing platform for monitoring and troubleshooting microservices. To deploy Jaeger:

```bash
kubectl apply -f HPA/jaeger.yaml
```
Contributing
We welcome contributions! To contribute to the project:

Fork the repository.
Create a new feature branch (git checkout -b feature-branch).
Make your changes and commit them (git commit -m 'Add new feature').
Push to the branch (git push origin feature-branch).
Open a pull request.
Please ensure that your code adheres to the project's coding standards and includes relevant tests.

License
This project is licensed under the MIT License. See the LICENSE file for more details.
