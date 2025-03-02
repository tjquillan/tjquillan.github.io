#!/usr/bin/env bash

set -euo pipefail

BASE_DIR="$(realpath "$(dirname "$0")/..")"
BLOWFISH_PATH="${BASE_DIR}/themes/blowfish"
BLOWFISH_CONFIG_PATH="${BLOWFISH_PATH}/config.toml"
GITHUB_PAGES_WORKFLOW_PATH="${BASE_DIR}/.github/workflows/pages.yml"

git -C "${BLOWFISH_PATH}" fetch

if [ $# -eq 1 ]; then
    BLOWFISH_VERSION="$1"
else
    BLOWFISH_VERSION="$(git -C $BLOWFISH_PATH describe --tags --abbrev=0 origin/main)"
fi

git -C "${BLOWFISH_PATH}" checkout "${BLOWFISH_VERSION}"

HUGO_VERSION="$(sed -nr "s/^max = \"(.*)\"$/\1/p" "${BLOWFISH_CONFIG_PATH}")"
sed -r -i "" "s/(HUGO_VERSION:).*$/\1 ${HUGO_VERSION}/g" "${GITHUB_PAGES_WORKFLOW_PATH}"

git -C "${BASE_DIR}" add "${BLOWFISH_PATH}" "${GITHUB_PAGES_WORKFLOW_PATH}"
if ! git diff --cached --quiet; then
    git -C "${BASE_DIR}" commit -m "Update Blowfish to ${BLOWFISH_VERSION}"
fi
