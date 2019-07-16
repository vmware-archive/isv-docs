#!/usr/bin/env bash

DIR="$(cd "$(dirname "$0")" && pwd)"
docker run --rm -it -p 8000:8000 -v ${DIR}:/docs dherbrich/mkdocs-material-awesome-pages:0.1.0
