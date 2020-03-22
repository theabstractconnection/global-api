#!/usr/bin/bash
rake secret
make shell cmd="rake db:create && rake db:migrate"