# Capistrano::Crono::Monit

Monit integration with capistrano-crono

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-crono-monit', group: :development

And then execute:

    $ bundle install

## Usage
```ruby
    # Capfile

    require 'capistrano/crono/monit'
```

## Dependencies
- capistrano-crono 0.1.2

## Customizing the monit crono templates

If you need change config for Monit, you can:

```
    bundle exec rails generate capistrano:crono:monit:template

```
## Contributing
Feel free to contribute.