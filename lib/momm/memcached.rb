require 'dalli'

module Momm
  class Memcached < Storage

    DEFAULT_OPTIONS = {
      connection: "localhost:11211", namespace: "momm", compress: true
    }.freeze

    attr_reader :connection, :options

    def initialize(options = DEFAULT_OPTIONS.dup)
      @connection = options.delete(:connection)
      @options = options
    end

    def client
      @client ||= Dalli::Client.new connection, options
    end
  end
end