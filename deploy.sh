#!/usr/bin/env bash

echo $1

if [[ -z $1 ]]; then
  echo "usage: deploy \"commit message\""
else
  echo "Deploying with commit message: $1"

  cd output
  git add .
  git commit -am "$1"
  git push

  echo "DONE."
fi
