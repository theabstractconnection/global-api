#!/usr/bin/env bash
# by default config/credentials.yml.enc is not in .gitignore
make shell cmd="rm -f config/credentials.yml.enc || true"
# generate secret.key & config/credentials.yml.enc
make shell cmd="EDITOR='mate --wait' bin/rails credentials:edit"
# create, migrate and seed database
make shell cmd="rake db:create"
make shell cmd="rake db:migrate"
make shell cmd="rake db:seed"
# restart service
make service