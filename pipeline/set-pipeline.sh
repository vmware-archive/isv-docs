#!/bin/bash
set -eux
DIR="$(cd "$(dirname "$0")" && pwd)"

echo ${DIR}/deploy-docs.yml

fly -t "${CONCOURSE_TARGET_NAME}" set-pipeline -p isvtechhub-deploy-docs -c "${DIR}/deploy-docs.yml" \
    -v isv-tech-docs-deploy-key-ci="$(lpass show "Shared-CF Platform Engineering/isv-tech-hub/isv-tech-docs-pipeline-deploy-key" --field "Private Key")" \
    -v isv-tech-hub-deploy-key-ci="$(lpass show "Shared-CF Platform Engineering/isv-tech-hub/isv-tech-hub-pipeline-deploy-key" --field "Private Key")"
