#!/bin/bash
# Only deploy branch builds
if [ "${TRAVIS_BRANCH}" != "${TRAVIS_TAG}" ]; then
  echo "Performing a deploy on ${TRAVIS_BRANCH}"
  mvnw -e -B -ntp -settings .mvn/settings.xml -P ossrh deploy
fi
