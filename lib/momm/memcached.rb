require 'dalli'

module Momm
  class Memcached

    DEFAULT_CONNECTION = "localhost:11211"
    DEFAULT_OPTIONS = { namespace: "momm", compress: true }

    attr_reader :connection, :options

    def initialize(connection = DEFAULT_CONNECTION, options = DEFAULT_OPTIONS)
      @connection = connection
      @options = options
    end

    def client
      @client ||= Dalli::Client.new
    end

    def set_rate(date, currency, rate)
      client.set [date, currency], rate
    end

    def get_rate(date, currency)
      client.get [date, currency]
    end

    def exchange_rate(from, to, date = Date.today)
      get_rate(date, to) / get_rate(date, from)
    end
  end
end