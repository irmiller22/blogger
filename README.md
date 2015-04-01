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
  adapter: postgresql
  encoding: unicode
  pool: 5
  timeout: 5000
  database: blogger_production_db
```

The adapter key is set to the database adapter (Postgres, SQLite, MySQL, etc). The other key component is the database key - this should be set to the name of your database (you can choose to call it whatever you'd like).

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

## Starting up Heroku
