#!/bin/bash
# Set the version to build
mvnw -e versions:set -DnewVersion=${TRAVIS_TAG} -DgenerateBackupPoms=false
# Build, install, test then publish the artifacts
mvnw -q -e clean deploy -settings .mvn/settings.xml -P ossrh
# Set the next development snapshot version
mvnw -e release:update-versions -B
# Commit the changes
git add pom.xml
git commit --message "Next development version (build: ${TRAVIS_BUILD_NUMBER})"
git remote add origin git@github.com:ruffkat/urlmock.git >/dev/null 2>&1
git push --set-upstream origin master --quiet
