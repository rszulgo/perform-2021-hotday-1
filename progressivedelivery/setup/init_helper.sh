#!/bin/bash

DT_TENANT=${DT_TENANT:-none}
DT_API_TOKEN=${DT_API_TOKEN:-none}
DT_PAAS_TOKEN=${DT_PAAS_TOKEN:-none}
K8S_DOMAIN=${K8S_DOMAIN:-none}

KEPTN_ENDPOINT=${KEPTN_ENDPOINT:-none}
KEPTN_API_TOKEN=${KEPTN_API_TOKEN:-none}

if [[ "$DT_TENANT" == "none" ]]; then
    echo "You have to set DT_TENANT to your Tenant URL, e.g: abc12345.dynatrace.live.com or yourdynatracemanaged.com/e/abcde-123123-asdfa-1231231"
    echo "To learn more about the required settings please visit https://keptn.sh/docs/0.7.x/monitoring/dynatrace/install"
    exit 1
fi
if [[ "$DT_API_TOKEN" == "none" ]]; then
    echo "You have to set DT_API_TOKEN to a Token that has read/write configuration, access metrics, log content and capture request data priviliges"
    echo "If you want to learn more please visit https://keptn.sh/docs/0.7.x/monitoring/dynatrace/install"
    exit 1
fi
if [[ "$DT_PAAS_TOKEN" == "none" ]]; then
    echo "You have to set DT_PAAS_TOKEN to a PaaS Token as this is used to install the Dynatrace OneAgent Operator on k8s"
    echo "If you want to learn more please visit https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/deploy-oneagent-k8/?deploy-with-kubectl%3C-%3Edeploy-with-helm=deploy-with-helm"
    exit 1
fi
if [[ "$K8S_DOMAIN" == "none" ]]; then
    echo "You have gto set K8S_DOMAIN to the domain of your ingress, e.g: xxx.dynatrace.training"
    exit 1
fi

if [[ "$KEPTN_ENDPOINT" == "none" ]]; then
    KEPTN_ENDPOINT="http://keptn.$K8S_DOMAIN"
    echo "Defaulting KEPTN_ENDPOINT to $KEPTN_ENDPOINT"
fi

if [[ "$KEPTN_API_TOKEN" == "none" ]]; then
    KEPTN_API_TOKEN=\$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)
    echo "Retrieved KEPTN_API_TOKEN from keptn-api-token secret"
fi