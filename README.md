# Collective blog app

### Hexlet tests and linter status:
[![Actions Status](https://github.com/bulgakke/rails-project-64/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/bulgakke/rails-project-64/actions)

### App on Render:
▶️ https://collective-blog-qjve.onrender.com/

## Installation
```sh
git clone https://github.com/bulgakke/rails-project-64 ./collective_blog_rails/
cd collective_blog_rails
```
### development (local)

Pre-requisites:
 - Ruby (3.4.5)
 - libvips
 - postgresql on localhost:5432
 - yarn

```sh
bundle install
yarn install
# app uses sqlite3 in test env for Hexlet tests and Postgres for dev/prod,
# In case of database issues, try removing schema file to force migrations, not schema load
# rm db/schema.rb

rails db:create db:migrate db:seed
make test
make lint
bin/dev
```
then go to http://127.0.0.1:3000/

### development (docker)
Check Dockerfile for instructions

### production
This app was set up for deploying on Render

Provide a database service, set DATABASE_URL, RAILS_MASTER_KEY and SENTRY_DSN variables
