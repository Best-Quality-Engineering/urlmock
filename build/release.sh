#!/bin/bash
../mvnw versions:set -DnewVersion=${TRAVIS_TAG}
../mvnw deploy -settings settings.xml -P ossrh