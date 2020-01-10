#!/bin/bash
# Deploy a snapshot release if not tagged
if [ -z "${TRAVIS_TAG}" ]; then
  echo "Integrating $(mvnw org.apache.maven.plugins:maven-help-plugin:evaluate -Dexpression=project.version | egrep -v "(^\[INFO\])")"
  mvnw deploy -e -B -ntp -settings .mvn/settings.xml -P ossrh
fi
