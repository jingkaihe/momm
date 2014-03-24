require 'forwardable'

require "momm/version"
require "momm/feeds/ecb"
require "momm/storage"
require "momm/memcached"
require "momm/redis_store"
require "momm/calculator"
require "momm/bridge"
require "momm/rails"
module Momm

  class << self
    extend ::Forwardable

    # Default options setup
    #
    # == Example
    # Momm.setup do
    #   store :redis_store, host: "127.0.0.1"
    # end
    #
    def setup(&block)
      bridge.instance_eval(&block)
    end

    # delegate the exchange, :currencies, exchange_rate,
    # as well as meta programmed methods to module level
    delegate [:currencies, :exchange, :exchange_rate,
        :method_missing, :respond_to?, :update! ] => :calculator

    delegate [:store, :source ] => :bridge

    private

    # Delegate the calculator
    def calculator
      @calculator = Calculator.new bridge.storage, bridge.feed
    end

    # Delegate the bridge
    def bridge
      @bridge ||= Bridge.new
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