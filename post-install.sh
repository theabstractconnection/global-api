#!/usr/bin/bash
bundle install
make shell cmd="rm -f config/credentials.yml; EDITOR='mate --wait' bin/rails credentials:edit"
make shell cmd="rake db:create && rake db:migrate"