PDNS
=======

The PDNS is PowerDNS API mountable engine for Rails.

Backends   | Support
--------   | -------
MySQL      | ○
PostgreSQL | -
Sqlite3    | -

[![Travis](https://img.shields.io/travis/linyows/pdns.svg?style=flat-square)](https://travis-ci.org/linyows/pdns)
[![ruby gem](https://img.shields.io/gem/v/pdns.svg?style=flat-square)](https://rubygems.org/gems/pdns)

Installation
------------

Add this line to your application's Gemfile:

```rb
gem 'pdns'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install pdns
```

Usage
-----

config/routes.rb:

```rb
mount PDNS::Engine, at: '/dns'
```

setup:

```sh
$ bin/rails generate pdns:install
$ bin/rails pdns:create
$ bin/rails pdns:setup
```

Development
-----------

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Contributing
------------

Bug reports and pull requests are welcome on GitHub at https://github.com/linyows/pdns.

Author
------

- [linyows](https://github.com/linyows)

License
-------

The MIT License (MIT)
