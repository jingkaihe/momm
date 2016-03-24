# Momm

[![Build Status](https://travis-ci.org/jaxi/momm.svg?branch=master)](https://travis-ci.org/jaxi/momm)

Money on My Mind - A pure Ruby gem for currency exchange.

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


Ensure that either [Memcached](http://memcached.org/) or [Redis](http://redis.io/) is installed on the machines/servers for exchange rate store

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


After the gem is installed, momm provide you a command line tool. The storage engine by default is Memcached. Make sure that its running in the background. Also make sure that you got the `dalli` gem installed

```
  $ momm rate GBP CNY                  # Exchange rate by default is today.
  $ momm exchange 100 GBP USD 2014-3-1 # Exchange rate at 2013-3-1
  $ momm update                        # Fetch feeds from remote and update the storage
```

#### Ruby


``` ruby
  require 'dalli' # Make sure that dalli is required before momm
  require 'momm'

  Momm.exchange_rate 'GBP', 'USD' # By default Today
  Momm.exchange_rate 'GBP', 'USD', date: Date.today

  Momm.exchange 100, 'GBP', 'USD'
  Momm.exchange 100, 'GBP', 'USD', date: Date.today
  Momm.exchange_from_gbp_to_usd 100

  Momm.update! # Fetching the feeds from remote. Only do that if you find any abnormal.
```

#### Configuration


``` ruby
  Momm.store :redis_store # Use redis as the default storage. Ensure 'redis' & 'redis-namespace is installed'

  Momm.fed :ECB # Use ECB as the default currency exchange feeds

  # Favoured way of configuration
  Momm.setup do
    store :redis_store, host: "127.0.0.1", namespace: "green_tea"
  end

```

### Momm on Rails


Web service is provided by Momm on Rails, however you need to install sinatra simply by adding ```gem 'sinatra'``` into your Gemfile. Then require ```momm/web``` module and edit your routes like:

``` ruby
  # routes.rb
  require 'dalli'
  require 'momm/web'

  Myapp::Application.routes.draw do
    mount Momm::Web => '/momm'
  end
```

If you want to switch to Redis, you can create an initialzer like:

``` ruby
  # Gemfile
  gem 'redis'
  gem 'redis-namespace'

  # momm_initialzer.rb

  Momm.setup do
    store :redis_store, host: "127.0.0.1", namespace: "green_tea"
  end
```

After boot your rails application, you can visit '/momm'. A mounted app has already been in place.


#### Small widget(You can insert it anywhere in your HTML files)

After mounted the engine to Rails, without configuration, you can simply copy & paste the widget code to your HTML files.

```echo '//= require money-on-my-mind' >> app/assets/javascripts/application.js ``` to insert home made js to your assets.

No stylesheets included, so it might look sucks a bit. Feel free to add your own css.

Widget of [SLIM](http://slim-lang.com/) template looks like below. Currenly only safe for work for Rails templates.

``` ruby
  .momm data-url="/momm/query"
    p
      | Date:
      input.mom-ele.momm-date type="text" /
    p
      | How much:
      input.mom-ele.momm-money type="text" value="1" /
    p
      | From:
      select.mom-ele.momm-from
        = options_for_select(Momm.currencies)
    p
      | To:
      select.mom-ele.momm-to
        = options_for_select(Momm.currencies)
    p
      | Exchange:
      span.momm-exchange
```


## Hate Rails? How about a Rack app? (Sigh)

``` ruby
  # config.ru
  require 'dalli' # again make sure that dalli is required beforehand!!!
  require 'momm/web'
  run Momm::Web
```

Just rack it up!

## How to Test

``` bash
  $ rake rspec
```

## Contributing

1. Fork it ( https://github.com/jaxi/momm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
