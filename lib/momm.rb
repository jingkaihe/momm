require 'forwardable'

require "momm/version"
require "momm/feeds/ecb"
require "momm/storage"
require "momm/memcached"
require "momm/redis_store"
require "momm/calculator"

module Momm

  class << self
    extend ::Forwardable

    def setup(&block)
      yield if block_given?
    end

    # Inject the storage into class variable
    #
    # == Parameters
    # storage_name::
    # :redis_store or memcached. Memcached is set as default.
    #
    # == Returns
    # the picked storage
    #
    # == Examples
    # store :redis_store, port: 12345
    #
    def store(storage_name, kv={})
      @storage = begin
        name = storage_name.to_s.split('_').map(&:capitalize).join
        klass = Kernel.const_get("Momm::#{name}")

        kv == {} ? klass.new : klass.new(kv)
      end
    end

    # Inject the storage into class variable
    #
    # == Parameters
    # feed_name::
    # currently only support ECB
    #
    # == Returns
    # the picked feed
    #
    # == Examples
    # source :ECB (which is by default)
    #
    def source(feed_name)
      @feed = Kernel.const_get("Momm::Feeds::#{feed_name}")
    end

    attr_reader :storage, :feed

    # delegate the exchange, exchange_rate, as well as meta programmed methods to module level
    delegate [:exchange, :exchange_rate, :method_missing, :respond_to?] => :calculator

    private

    # Delegate the calculator
    def calculator
      @calculator ||= if storage && feed
        Calculator.new storage, feed
      else
        Calculator.new
      end
    end
  end
end