#!/bin/bash
set -v
# Deploy a snapshot release if not tagged
if [ -z "${TRAVIS_TAG}" ]; then
    mvnw deploy -e -B --no-transfer-progress -settings .mvn/settings.xml -P ossrh
fi
