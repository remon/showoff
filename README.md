## SHOWOFF APP

### A Ruby on Rails Application for interacting with ShowOff API

- Ruby version : 2.5.3

- Rails Version 5.2.4

Check [Demo](http://github.com) on [Heroku](http://heroku.com)

### Run locally

- Clone the Repo
- run `bundle install`
- update rails credentials `EDITOR="vim" rails credentials:edit`

```
development:
  db:
   username: <your postgresql username>
   password: <your postgresql password>
```

- run `rails db:create`
- run `rails server`

#### run tests locally

- run `rspec` command

### CI/CD with TravisCi and Heroku

- you must have an account on [TravisCi](https://travis-ci.org) and [Heroku](https://www.heroku.com/)

* you must have both heroku cli and travis cli in your local machine
* fork the repo and clone it in your local machine
* update your travis.yml file with your credentails .
* commit changes then push it into your forked repo .
* enable the repo from your travis dashboard
* for more info on how to enable building a forked repo with TravisCi ,[click here ](https://stackoverflow.com/questions/26343492/test-a-forked-github-project-by-travis)
* create a new app from heroku dashboard or cli
* get encrepted api key by running `travis encrypt $(heroku auth:token) --add deploy.api_key` from your project directory , [click here](https://docs.travis-ci.com/user/deployment/heroku/)
* add your new heroku app name in travis.yml file
* commit changes and push it to your repo .
