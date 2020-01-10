#!/bin/bash
# Set the version to build
mvnw versions:set -e -B --no-transfer-progress -DnewVersion=${TRAVIS_TAG} -DgenerateBackupPoms=false
# Build, install, test then publish the artifacts
mvnw clean deploy -e -B --no-transfer-progress -settings .mvn/settings.xml -P ossrh
# Set the next development snapshot version
mvnw release:update-versions -e -B --no-transfer-progress -P ossrh
# Commit the changes
git checkout -b release/${TRAVIS_TAG}
git add pom.xml
git commit --message "Next development version (build: ${TRAVIS_BUILD_NUMBER})"
git remote add urlmock-origin git@github.com:ruffkat/urlmock.git >/dev/null 2>&1
git push --set-upstream urlmock-origin master --quiet
