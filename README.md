# Momm

Money on My Mind - An awesome gem for currency exchange.

## Requirement

Ensure that [Memcached](http://memcached.org/) or [Redis](http://redis.io/) is installed on your local machine or server or provided by some other cloud service providers. Those are for exchange rate storage, which ensure your fast queries.

Local storage is not provided, because it might not safe for work on Cloud Platforms such as Heroku.

## Installation

Add this line to your application's Gemfile:

    gem 'momm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install momm

## Usage

### Off Rails

#### @TODO Command Line

The storage engine by default is Redis, ensure the socket is opened.

```
  $ momm 100 GBP to USD # Exchange rate by default is today.
  $ momm 100 GBP to USD 2014-3-1 # Exchange rate at 2013-3-1
```

If you want to change the storage strategies, edit it in your ~/.mom/config.yml file.

#### Ruby

``` ruby
  require 'momm'

  Momm.exchange_rate 'GBP', 'USD' # By default Today
  Momm.exchange_rate 'GBP', 'USD', date: Date.today
  Momm.exchange_rate_from_gbp_to_usd, date: "2014-3-4"

  Momm.exchange 100, 'GBP', 'USD'
  Momm.exchange 100, 'GBP', 'USD', date: Date.today
  Momm.exchange_from_gbp_to_usd 100
  Momm.exchange_from_gbp_to_usd 100, date: "2014-3-4"

```

#### Configuration

``` ruby

  Momm.store :redis_store # Use redis as the default storage

  Momm.fed :ECB # Use ECB as the default currency exchange feeds

```

### Momm on Rails

# @TODO

## Contributing

1. Fork it ( https://github.com/[my-github-username]/momm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
