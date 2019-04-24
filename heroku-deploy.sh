#!/bin/bash

cd frontend
bundle
bundle exec middleman build --clean
cd ../
cp -r frontend/build/ public/
