#!/bin/bash
set -v
if [ -z "${TRAVIS_TAG}" ]; then
    mvnw deploy -e -B --no-transfer-progress -settings .mvn/settings.xml -P ossrh
fi
