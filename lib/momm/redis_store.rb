require 'redis'

module Momm
  class RedisStore
    DEFAULT_OPTIONS = { host: "localhost", port: 6379, namespace: "momm"}

    attr_accessor :options

    # Initialise RedisStore Object
    #
    # == Parameters:
    # options::
    #   Configuration of the redis connection
    # == Returns
    # self
    #
    def initialize(options = DEFAULT_OPTIONS.dup)
      @options = options
    end

    # Lazy load the RedisStore Client
    #
    # == Returns
    # the RedisStore Client
    #
    def client
      @client ||= begin
        ns = options.delete(:namespace)

        require 'redis/namespace'
        native_client = Redis.new options

        Redis::Namespace.new(ns, :redis => native_client)
      end
    end

    # Insert the currency rate to client
    #
    # == Parameters
    # date::
    #   Ruby date type, the date of currency rate
    # currency::
    #   Currency passed in, should be a symbol of iso code,
    #   such as :CNY, :USD, or :GBP
    # rate::
    #   Fixnum represent for the currency rate
    #   from euro to certain currency
    #
    # == Returns
    # nil
    #
    def set_rate(date, currency, rate)
      client["#{date}#{currency}"] = rate
    end

    # Fetch the currency rate from client
    #
    # == Parameters
    # date::
    #   Ruby date type, the date of currency rate
    # currency::
    #   Currency passed in
    #
    # == Returns
    # the currency rate
    #
    def get_rate(date, currency)
      client["#{date}#{currency}"].to_f
    end

    # Exchange Rate
    # == Parameters
    # from::
    #   ruby symbol, such as :USD, :GBP
    # to::
    #   same as above
    # date::
    #   Option parameter, represent for
    #   the exchange date, is today by default
    #
    # == Returns
    # the exchange rate
    #
    def exchange_rate(from, to, date = Date.today)
      get_rate(date, to) / get_rate(date, from)
    end
  end
end