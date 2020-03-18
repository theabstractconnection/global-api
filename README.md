# README  

## BUILD CONTAINERS
`docker-compose build`  

## START SERVICES
`make target=web build service`  

## SETUP DB
`make target=web cmd="rails db:create && rails db:migrate"`  