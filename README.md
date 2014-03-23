# Momm

Money on My Mind - An awesome gem for currency exchange.

```
                   __  __                                        __  __
                  |  \/  |                                      |  \/  |
                  | \  / | ___  _ __   ___ _   _    ___  _ __   | \  / |_   _
                  | |\/| |/ _ \| '_ \ / _ \ | | |  / _ \| '_ \  | |\/| | | | |
                  | |  | | (_) | | | |  __/ |_| | | (_) | | | | | |  | | |_| |
                  |_|  |_|\___/|_| |_|\___|\__, |  \___/|_| |_| |_|  |_|\__, |
                                            __/ |                        __/ |
                                           |___/                        |___/
                                       __  __ _           _
                                      |  \/  (_)         | |
                                      | \  / |_ _ __   __| |
                                      | |\/| | | '_ \ / _` |
                                      | |  | | | | | | (_| |
                                      |_|  |_|_|_| |_|\__,_|


                            Keep calm bro. We'll calculate rate for you.

```

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

#### Command Line Tool

The storage engine by default is Memcached, ensure the socket is opened.

```
  $ momm rate GBP CNY                  # Exchange rate by default is today.
  $ momm exchange 100 GBP USD 2014-3-1 # Exchange rate at 2013-3-1
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

Web service is provided by Momm on Rails, however you need to install sinatra simply by adding ```gem 'sinatra'``` into your Gemfile. Then require ```momm/web``` module and edit your routes like:

``` ruby
  # routes.rb

  require 'momm/web'

  Myapp::Application.routes.draw do
    mount Momm::Web => '/momm'
  end
```

The default Storage is Memcached, if you want to switch to Redis, you can create an intialzier like:

``` ruby

  # momm_initialzer.rb
  Momm.store :redis_store, host: "127.0.0.1"
  Momm.source :ECB
```

### @TODO: A small widget

## Contributing

1. Fork it ( https://github.com/jaxi/momm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
