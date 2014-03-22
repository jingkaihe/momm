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
    def initialize(storage = Memcached.new, feed = Feeds::ECB.instance)
      @storage = storage
      @feed = feed
    end

    attr_reader :storage, :feed

    # Delegate the client and update method from storage
    delegate [:client, :update, :set_rate] => :storage
    def_delegator :storage, :get_rate, :get_rate_origin

    # Exchange Rate
    #
    # == Parameters
    # from::
    #   ruby symbol, such as :USD, :GBP
    # to::
    #   same as above
    # options::
    #   0ption parameters, contain today by default
    #
    # == Returns
    # the exchange rate
    #
    def exchange_rate(from, to, options = {})
      date = options[:date] || Date.today
      get_rate(to, date) / get_rate(from, date)
    end

    # Exchange Money from one currency to another
    #
    # == Parameters
    # money::
    #   money you have
    # from::
    #   ruby symbol, such as :USD, :GBP
    # to::
    #   same as above
    # options::
    #   option parameters, contain today by default
    #
    # == Returns
    # money exchanged
    #
    def exchange(money, from, to, options= {})
      date = options[:date] || Date.today
      (money * exchange_rate(from, to, options)).round(2)
    end

    # Delegate the get_rate method, if the target is missing
    # Fetching all data from remote
    #
    # == Parameters
    #
    # date::
    #   Default is Date.today
    # currency::
    #   Currency passed in
    # == Returns
    # the currency rate
    #
    def get_rate(from, date = Date.today)
      res = get_rate_origin(from, date)
      return res if res != 0 && res

      update(feed.currency_rates)
      get_rate_origin(from, date)
    end

    # @TODO: Refactoring
    def method_missing(meth, *args, &block)
      meth = meth.to_s
      case
      when meth.match(/^exchange_rate_from_(\w+)_to_(\w+)/)
        exchange_rate($1.upcase.to_sym, $2.upcase.to_sym, *args, &block)
      when meth.match(/^exchange_from_(\w+)_to_(\w+)/)
        money, *res = args
        exchange(money, $1.upcase.to_sym, $2.upcase.to_sym, *res, &block)
      else
        super
      end
    end

    def respond_to?(meth, include_private = false)
      meth = meth.to_s
      meth.match(/^exchange_rate_from_(\w+)_to_(\w+)/) ||
        meth.match(/^exchange_from_(\w+)_to_(\w+)/) ||
          super
    end
  end
end