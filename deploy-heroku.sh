#!/bin/bash

cd frontend && bundle exec middleman build --clean
cd ../
rm -r public/*
cp -r frontend/build/ public/
