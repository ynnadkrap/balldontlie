#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Release version required"
    exit 1
  fi

docker build -t gcr.io/balldontlie/client:$1 ./frontend
docker push gcr.io/balldontlie/client:$1
sed -i '' -E "s/version:.*$/version: $1/g" deploy/client/Chart.yaml
sed -i '' -E "s/gcr.io\/balldontlie\/client:.*$/gcr.io\/balldontlie\/client:$1/g" deploy/client/templates/deployment.yaml
helm upgrade geared-jellyfish deploy/client
git commit -am "Release client $1"
