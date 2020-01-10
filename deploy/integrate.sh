#!/bin/bash
set -v
bundle exec rake:units
if [ "${TRAVIS_TAG}" ]; then
  
fi
