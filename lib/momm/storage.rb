module Momm
  class Storage
    # The presenter model to rule the behavior of storage.

    # Lazy load  Client
    #
    # == Returns
    #  Client
    #
    def client
      raise NotImplementedError
    end

    # Insert the currency rate to client
    #
    # == Parameters
    # date::
    #   Ruby date type, the date of currency rate
    # currency::
    #   Currency passed in, should be a symbol of iso code,
    #   such as :CNY, :USD, or :GBP
    # rate::
    #   Fixnum represent for the currency rate
    #   from euro to certain currency
    #
    # == Returns
    # nil
    #
    def set_rate(date, currency, rate)
      raise NotImplementedError
    end

    # Fetch the currency rate from client
    #
    # == Parameters
    # date::
    #   Ruby date type, the date of currency rate
    # currency::
    #   Currency passed in
    #
    # == Returns
    # the currency rate
    #
    def get_rate(date, currency)
      raise NotImplementedError
    end

    # Exchange Rate
    # == Parameters
    # from::
    #   ruby symbol, such as :USD, :GBP
    # to::
    #   same as above
    # date::
    #   Option parameter, represent for
    #   the exchange date, is today by default
    #
    # == Returns
    # the exchange rate
    #
    def exchange_rate(from, to, date = Date.today)
      raise NotImplementedError
    end

    NotImplementedError = Class.new(StandardError)
  end
end