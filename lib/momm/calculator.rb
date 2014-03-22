require 'forwardable'

module Momm
  class Calculator
    extend ::Forwardable
    # Initialise Storage Object
    #
    # == Parameters:
    # client::
    #   A storage, such as memcached, redis
    # == Returns
    # self
    #
    def initialize(storage = Memcached.new)
      @storage = storage
    end

    attr_reader :storage

    # Delegate the client from storage
    delegate [:client, :set_rate, :get_rate, :exchange_rate] => :storage
  end
end