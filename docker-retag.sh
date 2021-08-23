#!/usr/local/bin/bash -x
export SOURCE_TAG=johnasexton/openjdk-alpine:11.08-3.12
export TARGET_TAG=johnasexton/openjdk-alpine:latest

# retag docker image
echo "retagging docker tag ${SOURCE_TAG} as ${TARGET_TAG}"
docker tag ${SOURCE_TAG} ${TARGET_TAG}

# push new docker tag
echo "pushing docker tag ${TARGET_TAG}"
docker push ${TARGET_TAG}
