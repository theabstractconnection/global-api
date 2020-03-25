[![Generic badge](https://img.shields.io/badge/Licence-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Generic badge](https://img.shields.io/badge/Made&#32;With-&#10084;&#32;&#64;&#32;TheAbstractConnection-red.svg)](https://github.com/theabstractconnection)
[![Generic badge](https://img.shields.io/badge/Website-UP-green.svg)](https://api.theabstractconnection.com)
[![Generic badge](https://img.shields.io/badge/Build-PASSING-green.svg)]()
[![Generic badge](https://img.shields.io/badge/Use&#32;@&#32;Your&#32;Own&#32;Risks-&#9762;&#9760;&#9762;-red.svg)](https://opensource.org/licenses/MIT)
[![Generic badge](https://img.shields.io/badge/Ask&#32;Me-Anything-blue.svg)](https://github.com/abstracts33d/ama)  

[![Maintainability](https://api.codeclimate.com/v1/badges/36f82991bec9ecf13c4f/maintainability)](https://codeclimate.com/github/theabstractconnection/global_api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/36f82991bec9ecf13c4f/test_coverage)](https://codeclimate.com/github/theabstractconnection/global_api/test_coverage)



# GLOBAL_API  
## GENERATE SECRET
`rake secet`  

## SETUP ENV VARS IN  
create .env file  
```
DEVISE_JWT_SECRET_KEY=
HOSTNAME=
```  
## BUILD CONTAINERS
`make build`  

## START SERVICES
`make service`  

## SETUP DB
`make cmd="rails db:create && rails db:migrate"`  