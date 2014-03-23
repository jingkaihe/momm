require 'redis'

module Momm
  class RedisStore < Storage
    DEFAULT_OPTIONS = { host: "localhost", port: 6379, namespace: "momm"}

    attr_accessor :options

    def initialize(options = {})
      @options = DEFAULT_OPTIONS.dup.merge options
    end

    def client
      @client ||= begin
        ns = options.delete(:namespace)

        require 'redis/namespace'
        native_client = Redis.new options

        Redis::Namespace.new(ns, :redis => native_client)
      end
    end
  end
end