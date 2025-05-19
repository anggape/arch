#!/usr/bin/env bash

git config --global --add safe.directory ${GITHUB_WORKSPACE}

tag_id=0
function create_tag() {
  tag_id=$((tag_id + 1))
  release_tag="$(date '+%Y/%m/%d').$tag_id"
  if [ $(git tag -l "${release_tag}") ]; then
    create_tag ${TAG_ID}
  else
    git tag "${release_tag}"
    echo "RELEASE_TAG=${release_tag}" | tee --append $GITHUB_OUTPUT
  fi
}
create_tag
