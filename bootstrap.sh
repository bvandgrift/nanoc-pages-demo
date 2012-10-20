#!/usr/bin/env bash

if [ ! -d "./output" ]; then
  echo "Bootstrapping gh-pages into ./output"
  mkdir ./output
  git clone git@github.com:bvandgrift/nanoc-pages-demo.git output
  cd output && git checkout gh-pages

  echo "Setup complete! use deploy.sh to deploy the site.."
else
  echo "Seems there is already an ./output dir."
  echo "Clean up and try again."
  exit 1
fi

