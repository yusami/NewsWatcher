#!/bin/sh

if [ -e vendor ]; then
  echo "gems are already installed."
else
  echo "Installing gems..."
  bundle install --path vendor/bundle --without development test
fi
