# Heroku Deployment Lab

## Steps
- [Add postgres configurations to `database.yml`](#postgres)
- Add `rails_12factor` gem
- Deploy to Heroku
- Run migrations, start up dyno

## Postgres
- In your Gemfile, you need to namespace a `production` group, so that there will be a set of gems that install only in the production environment.

```ruby
# Gemfile
group :production do
  ...
end
```

- Let's add the `pg` gem to the Gemfile, since that's what our Heroku server will be using as its primary database.

```ruby
# Gemfile
group :production do
  gem 'pg'
end
```

- Let's also set up the `database.yml` configuration file for our database.

```yaml
# config/database.yml
production:
  url: <%= ENV["DATABASE_URL"] %>
```

Heroku automatically sets up a database for you once you push up to Heroku, and the `DATABASE_URL` config variable is given to you by heroku. So once the Heroku app builds after being deployed, your application will then connect to the database through the `url` key in the `database.yml` file.

## Rails 12 Factor

What is [`12 Factor`](https://github.com/heroku/rails_12factor)? It's a [set of guidelines](http://12factor.net/) that provides a framework for a methodology of building well-designed and built software applications. A 12 factor app does the following things:

- Use declarative formats for setup automation, to minimize time and cost for new developers joining the project;
- Have a clean contract with the underlying operating system, offering maximum portability between execution environments;
- Are suitable for deployment on modern cloud platforms, obviating the need for servers and systems administration;
- Minimize divergence between development and production, enabling continuous deployment for maximum agility;
- And can scale up without significant changes to tooling, architecture, or development practices.

The `rails_12factor` gem provides our Heroku production environment with two key components: it enables the serving of assets in a production environment, and it also sets your application logger to `STDOUT`, meaning that your log is output in your server terminal (you can access this via `heroku logs`).

So let's add the `rails_12factor` gem to our production group in the Gemfile:

```ruby
# Gemfile
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
```

## Deploying to Heroku

So now that we have the gems and the database configurations set up in our application, it's now time to start the Heroku deployment process. Let's create a new heroku application from our command line:

```bash
heroku create
```

This will create an application for you on Heroku. The output will look something like this:

```bash
Creating apple-pie-6732... done, stack is cedar-14
https://apple-pie-6732.herokuapp.com/ | https://git.heroku.com/apple-pie-6732.git
Git remote heroku added
```

This will give you a new application on Heroku. This also gives you a remote that is called `heroku`. For example, when I run `git remote -v`, this is the output I'd get:

```bash
heroku  https://git.heroku.com/apple-pie-6732.git (fetch)
heroku  https://git.heroku.com/apple-pie-6732.git (push)
origin  git@github.com:irmiller22/blogger.git (fetch)
origin  git@github.com:irmiller22/blogger.git (push)
```

Now let's push our application to the Heroku server. By default, when the Heroku application push command is invoked, it will push the `master` branch of your Github repository to the Heroku remote. From there, the application will build. So let's push our `master` branch up.

```bash
git push heroku master
```

This results in the following:

```bash
Counting objects: 6, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 571 bytes | 0 bytes/s, done.
Total 6 (delta 3), reused 0 (delta 0)
To git@github.com:irmiller22/blogger.git
   6c8676a..85d0b50  heroku-deploy -> heroku-deploy
[13:52:30] (heroku-deploy) blogger
✯ git push heroku heroku-deploy:master
Counting objects: 135, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (127/127), done.
Writing objects: 100% (135/135), 27.16 KiB | 0 bytes/s, done.
Total 135 (delta 34), reused 0 (delta 0)
remote: Compressing source files... done.
remote: Building source:
remote:
remote: -----> Ruby app detected
remote: -----> Compiling Ruby/Rails
remote: -----> Using Ruby version: ruby-2.2.0
remote: -----> Installing dependencies using 1.7.12
remote:        Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
remote:        Fetching gem metadata from https://rubygems.org/...........
remote:        Using rake 10.4.2
remote:        Installing i18n 0.7.0
remote:        Installing minitest 5.5.1
remote:        Installing builder 3.2.2
remote:        Installing thread_safe 0.3.5
remote:        Installing mini_portile 0.6.2
remote:        Installing erubis 2.7.0
remote:        Installing rack 1.6.0
remote:        Installing mime-types 2.4.3
remote:        Installing arel 6.0.0
remote:        Installing coffee-script-source 1.9.1
remote:        Installing execjs 2.4.0
remote:        Installing json 1.8.2
remote:        Installing hike 1.2.3
remote:        Installing thor 0.19.1
remote:        Using bundler 1.7.12
remote:        Installing multi_json 1.11.0
remote:        Installing tilt 1.4.1
remote:        Installing rails_stdout_logging 0.0.3
remote:        Using rdoc 4.2.0
remote:        Installing rails_serve_static_assets 0.0.4
remote:        Installing tzinfo 1.2.2
remote:        Installing sass 3.4.13
remote:        Installing rack-test 0.6.3
remote:        Installing mail 2.6.3
remote:        Installing coffee-script 2.3.0
remote:        Installing uglifier 2.7.1
remote:        Installing sprockets 2.12.3
remote:        Installing sdoc 0.4.1
remote:        Installing rails_12factor 0.0.3
remote:        Installing activesupport 4.2.0
remote:        Installing rails-deprecated_sanitizer 1.0.3
remote:        Installing globalid 0.3.3
remote:        Installing activemodel 4.2.0
remote:        Installing jbuilder 2.2.12
remote:        Installing activejob 4.2.0
remote:        Installing activerecord 4.2.0
remote:        Installing nokogiri 1.6.6.2
remote:        Installing rails-dom-testing 1.0.6
remote:        Installing loofah 2.0.1
remote:        Installing rails-html-sanitizer 1.0.2
remote:        Installing actionview 4.2.0
remote:        Installing actionpack 4.2.0
remote:        Installing actionmailer 4.2.0
remote:        Installing railties 4.2.0
remote:        Installing sprockets-rails 2.2.4
remote:        Installing pg 0.18.1
remote:        Installing coffee-rails 4.1.0
remote:        Installing jquery-rails 4.0.3
remote:        Installing sass-rails 5.0.3
remote:        Installing rails 4.2.0
remote:        Installing sprockets_better_errors 0.0.4
remote:        Installing turbolinks 2.5.3
remote:        Your bundle is complete!
remote:        Gems in the groups development and test were not installed.
remote:        It was installed into ./vendor/bundle
remote:        Post-install message from sprockets_better_errors:
remote:        To enable sprockets_better_errors
remote:        add this line to your config/environments/development.rb:
remote:        config.assets.raise_production_errors = true
remote:        Bundle completed (35.92s)
remote:        Cleaning up the bundler cache.
remote: -----> Preparing app for Rails asset pipeline
remote:        Running: rake assets:precompile
remote:        I, [2015-04-01T17:53:28.659802 #1175]  INFO -- : Writing /tmp/build_d7e9a4b2c801419fa0d11125217b5f9e/public/assets/application-57b2f8ae2b1d6383501ac3ed4b05d1c7.js
remote:        I, [2015-04-01T17:53:28.714753 #1175]  INFO -- : Writing /tmp/build_d7e9a4b2c801419fa0d11125217b5f9e/public/assets/application-3942007d31710307dd44000cb1f768c9.css
remote:        Asset precompilation completed (6.65s)
remote:        Cleaning assets
remote:        Running: rake assets:clean
remote:
remote: ###### WARNING:
remote:        No Procfile detected, using the default web server (webrick)
remote:        https://devcenter.heroku.com/articles/ruby-default-web-server
remote:
remote: -----> Discovering process types
remote:        Procfile declares types -> (none)
remote:        Default types for Ruby  -> console, rake, web, worker
remote:
remote: -----> Compressing... done, 29.9MB
remote: -----> Launching... done, v6
remote:        https://apple-pie-6732.herokuapp.com/ deployed to Heroku
remote:
remote: Verifying deploy... done.
To https://git.heroku.com/apple-pie-6732.git
 * [new branch]      heroku-deploy -> master
```

Once it has properly deployed, we can then go about starting up the Heroku server.

## Starting up Heroku

First off, we need to migrate our database on Heroku, and then seed the database (if we have any seeds). 

```bash
heroku run rake db:migrate
```

Then, if needed:

```bash
heroku run rake db:seed
```

Finally, if everything was done correctly, your app should be all set up. Now let's run `heroku restart` to restart our server, and then you should be good to go!

Run `heroku open` to see your application live!

## Resources

* [Heroku](http://heroku.com/) - [Deploying a Rails Application](https://devcenter.heroku.com/articles/getting-started-with-rails4#deploy-your-application-to-heroku)
