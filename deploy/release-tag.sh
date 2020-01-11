#!/bin/bash
echo "Releasing ${TRAVIS_TAG}"

# When triggered by a tag, the local git repository will be in
# a detached head mode, so create the release branch for it.
echo "Creating release branch: release/${TRAVIS_TAG}"
git switch -c release/${TRAVIS_TAG}

echo "Setting POM versions to ${TRAVIS_TAG}"
mvnw -e -B -ntp -settings .mvn/settings.xml -P ossrh -DgenerateBackupPoms=false -DnewVersion=${TRAVIS_TAG} versions:set

echo "Executing deploy goal for ${TRAVIS_TAG}"
mvnw -e -B -ntp -settings .mvn/settings.xml -P ossrh clean deploy

echo "Committing changes to release/${TRAVIS_TAG}"
git add pom.xml
git commit --message "Release ${TRAVIS_TAG} (build: ${TRAVIS_BUILD_NUMBER})"
git push -u ssh-origin release/${TRAVIS_TAG}

echo "Merging release/${TRAVIS_TAG} into master"
git checkout master
git pull
git merge release/${TRAVIS_TAG}
git push -u ssh-origin master

echo "Preparing next development version"
mvnw -e -B -ntp -settings .mvn/settings.xml -P ossrh release:update-versions
git add pom.xml
git commit --message "Next development version (build: ${TRAVIS_BUILD_NUMBER})"
git push -u ssh-origin master
