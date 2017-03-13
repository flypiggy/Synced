#!/usr/bin/env bash
set -e

echo "-> Setting environments"
openssl aes-256-cbc -K $encrypted_9e7da2809d56_key -iv $encrypted_9e7da2809d56_iv -in ../config/deploy.enc -out ../config/deploy_rsa -d

echo "-> Installing bundler gem"
gem install bundler

echo "-> Installing gem dependencies with bundler"
bundle install

echo "-> Deploying"
bundle exec cap production deploy
