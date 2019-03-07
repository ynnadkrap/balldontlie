#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Release version required"
    exit 1
  fi

docker build -t gcr.io/balldontlie/api:$1 .
docker push gcr.io/balldontlie/api:$1
sed -i '' -E "s/version:.*$/version: $1/g" deploy/api/Chart.yaml
sed -i '' -E "s/gcr.io\/balldontlie\/api:.*$/gcr.io\/balldontlie\/api:$1/g" deploy/api/templates/deployment.yaml
helm upgrade unsung-worm deploy/api
git commit -am "Release api $1"
