#!/bin/bash
set -eux
DIR="$(cd "$(dirname "$0")" && pwd)"

echo ${DIR}/deploy-docs.yml

fly -t "${CONCOURSE_TARGET_NAME}" set-pipeline -p isv-docs-deploy -c "${DIR}/deploy-docs.yml" \
    -v isv-docs-deploy-key-ci="$(lpass show "Shared-CF Platform Engineering/isv-tech-hub/isv-tech-docs-pipeline-deploy-key" --field "Private Key")"
