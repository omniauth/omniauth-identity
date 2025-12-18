#!/bin/sh
apt-get update -y

# Basic, commonly needed, dependencies of Ruby & JRuby projects
apt-get install -y direnv default-jdk git zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev

# Support for PostgreSQL
apt-get install -y postgresql libpq-dev

# Adds the direnv setup script to ~/.bashrc file (at the end)
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
