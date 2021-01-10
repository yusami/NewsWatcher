#!/bin/sh

if [ -e vendor ]; then
  echo "gems are already installed."
else
  echo "Installing gems..."
  bundle config build.nokogiri --use-system-libraries \
    --with-xml2-include=$(brew --prefix libxml2)/include/libxml2
  bundle config set --local path 'vendor/bundle'
  bundle config set --local without 'development test'
  bundle install
fi
