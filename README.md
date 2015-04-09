---
languages: ruby
tags: rspec, factorygirl
resources: 2
---

# FactoryGirl Introduction

FactoryGirl is a DSL for creating fixtures in your RSpec tests. Why is FactoryGirl a good gem to utilize? The major reason is test maintenance. Over the course of a Rails project, your assumptions about your models is likely to change over time. Let's take an example. What if we had to create normal fixtures/objects in our tests like below?

```ruby
before(:each) do
  product = Product.create(name: "Nerf Gun", type: "weapon", age: "13 and above")
end
```

Do you notice anything that would be hard to maintain? What if we changed the `type` attribute to `classification` attribute? If we had to go into every test suite and change that attribute, that would be a massive pain. And that's only for one model fixture/object. You can imagine how time consuming that would be if you had to fix this all across your test suites. It would be nice if we could do something like this:

```ruby
before(:each) do
  product = create(:product)
end
```

This is essentially what FactoryGirl does.

## Setting Up RSpec/FactoryGirl

Let's go ahead and include `rspec-rails`, `factory_girl_rails`, and `database_cleaner` in our Gemfile.

```ruby
# Gemfile

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end
```

If you put the `factory_girl_rails` gem only in the `:test` group and not the `:development` group as well, then the factories will not automatically be generated when a model spec is generated.

After we've run `bundle install`, lets go ahead and generate the RSpec resources. Run `rails g rspec:install`. You'll see the following output:

```
      create  .rspec
      create  spec
      create  spec/spec_helper.rb
      create  spec/rails_helper.rb
```

Then the next step is to add some configurations for FactoryGirl and DatabaseCleaner into our `rails_helper.rb` file. 

```ruby
# spec/rails_helper.rb

ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.infer_spec_type_from_file_location!
end

```

The `FactoryGirl::Syntax::Methods` configuration allows you to just write `create(:factory)` instead of `FactoryGirl.create(:factory)` inside of a spec. 

The `DatabaseCleaner` configuration ensures that you're cleaning out examples made for each test, so that you don't risk contaminating other fixtures created for other tests. This ensures that there is a clean database slate for each test that is run in a suite.

Now let's go ahead and generate our RSpec tests for our Post and Comment models. Run the following commands in your Terminal: `rails g rspec:model Post` and `rails g rspec:model Comment`. You'll see the following output:

```
rails g rspec:model Post
      create  spec/models/post_spec.rb
      invoke  factory_girl
      create    spec/factories/posts.rb

rails g rspec:model Comment
      create  spec/models/comment_spec.rb
      invoke  factory_girl
      create    spec/factories/comments.rb
```

Now we've got our test environment set up.

## Writing Tests

Let's go ahead and start writing out tests for our Post model.

## Resources

* [Github](http://github.com/) - [Getting Started with FactoryGirl](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md)
* [Slideshare](http://www.slideshare.net) - [Not So Brief Intro to FactoryGirl](http://www.slideshare.net/gabevanslv/factory-girl-15924188)
