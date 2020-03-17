# README

##BUILD CONTAINERS
`docker-compose build`

##START SERVICES
`docker-compose up`

##SETUP DB
`docker-compose run web rake db:create RAILS_ENV=production`
`docker-compose run web rake db:migrate RAILS_ENV=production`
