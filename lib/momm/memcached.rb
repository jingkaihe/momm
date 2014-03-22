require 'dalli'

module Momm
  class Memcached < Storage

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
  end
end