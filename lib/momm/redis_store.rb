require 'redis'

module Momm
  class RedisStore < Storage
    DEFAULT_OPTIONS = { host: "localhost", port: 6379, namespace: "momm"}

    attr_accessor :options

    def initialize(options = DEFAULT_OPTIONS.dup)
      @options = options
    end

    def client
      @client ||= begin
        ns = options.delete(:namespace)

        require 'redis/namespace'
        native_client = Redis.new options

        Redis::Namespace.new(ns, :redis => native_client)
      end
    end

    def set_rate(date, currency, rate)
      client["#{date}#{currency}"] = rate
    end

    def get_rate(date, currency)
      client["#{date}#{currency}"].to_f
    end

    def exchange_rate(from, to, date = Date.today)
      get_rate(date, to) / get_rate(date, from)
    end
  end
end