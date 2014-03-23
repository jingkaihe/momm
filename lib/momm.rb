require 'forwardable'

require "momm/version"
require "momm/feeds/ecb"
require "momm/storage"
require "momm/memcached"
require "momm/redis_store"
require "momm/calculator"
require "momm/rails"
module Momm

  class << self
    extend ::Forwardable

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
    def store(storage_name, **kv)
      @storage = begin
        name = storage_name.to_s.split('_').map(&:capitalize).join
        klass = Kernel.const_get("Momm::#{name}")

        klass.new **kv
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
      @feed = Kernel.const_get("Momm::Feeds::#{feed_name}").instance
    end

    attr_reader :storage, :feed

    # delegate the exchange, :currencies, exchange_rate,
    # as well as meta programmed methods to module level
    delegate [:currencies, :exchange, :exchange_rate,
        :method_missing, :respond_to?, :update! ] => :calculator

    private

    # Delegate the calculator
    def calculator
      @calculator = Calculator.new(
        (storage || Memcached.new), (feed || Feeds::ECB.instance))
    end
  end

  # YAS
  BANNER = <<-EOS
 __  __                                        __  __
|  \/  |                                      |  \/  |
| \  / | ___  _ __   ___ _   _    ___  _ __   | \  / |_   _
| |\/| |/ _ \| '_ \ / _ \ | | |  / _ \| '_ \  | |\/| | | | |
| |  | | (_) | | | |  __/ |_| | | (_) | | | | | |  | | |_| |
|_|  |_|\___/|_| |_|\___|\__, |  \___/|_| |_| |_|  |_|\__, |
                          __/ |                        __/ |
                         |___/                        |___/
                     __  __ _           _
                    |  \/  (_)         | |
                    | \  / |_ _ __   __| |
                    | |\/| | | '_ \ / _` |
                    | |  | | | | | | (_| |
                    |_|  |_|_|_| |_|\__,_|


            Keep calm bro. We'll calculate rate for you.
  EOS

end