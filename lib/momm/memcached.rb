require 'dalli'

module Momm
  class Memcached < Storage

    DEFAULT_OPTIONS = {
      connection: "localhost:11211", namespace: "momm", compress: true
    }.freeze

    attr_reader :connection, :options

    def initialize(options={})
      _options = DEFAULT_OPTIONS.dup.merge options
      @connection = _options.delete(:connection)
      @options = _options
    end

    def client
      @client ||= Dalli::Client.new connection, options
    end
  end
end