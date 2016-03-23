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

    # delegate the client and set_rate method from storage
    delegate [:client, :set_rate] => :storage

    # delegate the currencies method from feed
    delegate :currencies => :feed

    # delegate methods with different naming for overriding
    def_delegator :storage, :get_rate, :get_rate_origin
    def_delegator :storage, :update, :origin_update


    # Update the feeds. In most case, you do not need to call this,
    # because Momm will update the feeds everytime she find something missing ;)
    # == Returns
    # nil
    #
    def update!
      origin_update(feed.currency_rates)
    end

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
      origin_exchange_rate(from, to, options = {}).round(2)
    end

    # Exchange Rate without precision bound
    def origin_exchange_rate(from, to, options = {})
      date = options[:date] || Date.today
      date = Date.parse(date) if date.is_a? String

      max_count = 10
      date_counter = date

      # @TODO Refactoring.
      # It seems that currency does not have feeds at weekends, so
      # we simply find the closest day which has currency feeds.
      while max_count > 0
        to_rate = get_rate(to, date_counter)
        from_rate = get_rate(from, date_counter)

        date_counter -=1
        max_count -= 1
        next if to_rate == 0 || from_rate == 0

        set_rate(to, to_rate, date)
        set_rate(from, from_rate, date)

        return (to_rate / from_rate)
      end

      0.0 / 0
    end

    private :origin_exchange_rate

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
      options[:date] ||= Date.today
      (origin_exchange_rate(from, to, options) * money).round(2)
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

      update!
      get_rate_origin(from, date)
    end
  end
end
