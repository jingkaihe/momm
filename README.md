# Momm

Money on My Mind - An awesome gem for currency exchange.

## Installation

Ensure that [Memcached](http://memcached.org/) or [Redis](http://redis.io/) is installed on your local machine or server or provided by some other cloud service provider. Those are for exchange rate storage, which ensure your fast query.

You can also use local storage, however might NSFW at Cloud Platform such as Heroku.

Add this line to your application's Gemfile:

    gem 'momm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install momm

## Usage

### Off Rails

#### Command Line

The storage engine by default is Redis, ensure the socket is opened.

```
  $ momm 100 GBP to USD # Exchange rate by default is today.
  $ momm 100 GBP to USD 2014-3-1 # Exchange rate at 2013-3-1
```

If you want to change the storage strategies, edit it in your ~/.mom/config.yml file.

#### Ruby

``` ruby
  require 'momm'

  momm = Momm::Client.new
  momm.exchange_rate 'GBP', 'USD' # By default Today
  momm.exchange_rate 'GBP', 'USD', date: Date.today
  momm.exchange_rate_from_gbp_to_usd

  momm.exchange 100, 'GBP', 'USD'
  momm.exchange 100, 'GBP', 'USD', date: Date.today
  momm.exchange_from_gbp_to_usd 100

  # Fixnum Injection
  100.exchange from: "GBP", to "USD"
  100.exchange from: :GBP, to: :USD, date: Today
  100.exchange_from_gbp_to_usd

```

##### Configuration

``` ruby
  # Redis store

  Momm.setup do
    provider :redis
    connection '127.0.0.1:6379'
  end

  Momm.setup do
    provider :memcached
    connection '127.0.0.1:11211'
  end
```

### Momm on Rails

# @TODO

## Contributing

1. Fork it ( https://github.com/[my-github-username]/momm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
