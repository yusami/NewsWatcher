#!/bin/sh

if [ -e vendor ]; then
  echo "gems are already installed."
else
  echo "Installing gems..."
  bundle config build.nokogiri --use-system-libraries \
    --with-xml2-include=$(brew --prefix libxml2)/include/libxml2
  bundle install --path vendor/bundle --without development test
fi
