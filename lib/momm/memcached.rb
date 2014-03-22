require 'dalli'

module Momm
  class Memcached

    DEFAULT_CONNECTION = "localhost:11211".freeze
    DEFAULT_OPTIONS = { namespace: "momm", compress: true }

    attr_reader :connection, :options

    # Initialise Memcached Object
    #
    # == Parameters:
    # connection::
    #   A string represent for the port to memcached, can be socke or IP
    # options::
    #   Configuration of the memcached connection
    # == Returns
    # self
    #
    def initialize(connection = DEFAULT_CONNECTION, options = DEFAULT_OPTIONS)
      @connection = connection
      @options = options
    end

    # Lazy load the Memcached Client
    #
    # == Returns
    # The memcached Client
    #
    def client
      @client ||= Dalli::Client.new
    end

    # Insert the currency rate to Memcached
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
      client.set [date, currency], rate
    end

    # Fetch the currency rate from Memcached
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
      client.get [date, currency]
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
    def exchange_rate(from, to, date = Date.today)
      get_rate(date, to) / get_rate(date, from)
    end
  end
end