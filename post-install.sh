#!/usr/bin/bash
# by default config/credentials.yml.enc is not in .gitignore
make shell cmd="rm -f config/credentials.yml.enc || true"
# generate secret.key & config/credentials.yml.enc
make shell cmd="EDITOR='mate --wait' bin/rails credentials:edit"
# create and seed database
make shell cmd="rake db:create && rake db:migrate"
# link .env
ln -s /home/ec2-user/envs/global_api.env /home/ec2-user/projects/global_api/.env || true
# restart service
make service