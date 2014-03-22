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
    # currency::
    #   Currency passed in, should be a symbol of iso code,
    #   such as :CNY, :USD, or :GBP
    # rate::
    #   Fixnum represent for the currency rate
    #   from euro to certain currency
    # date::
    #   Ruby date type, the date of currency rate, today by default
    #
    # == Returns
    # nil
    #
    def set_rate(currency, rate, date = Date.today)
      date = Date.parse(date) if date.is_a? String
      client.set "#{date}#{currency}", rate
    end

    # Fetch the currency rate from client
    #
    # == Parameters
    # currency::
    #   Currency passed in
    # date::
    #   Ruby date type, the date of currency rate, today by default
    #
    # == Returns
    # the currency rate
    #
    def get_rate(currency, date = Date.today)
      date = Date.parse(date) if date.is_a? String
      client.get("#{date}#{currency}").to_f
    end

    # update the data to storage
    #
    # == parameters
    # data::
    #   An array looks like [{date: Date.now, currency: :CNY, rate: 1.23} ...]
    #
    # == Returns
    # nil
    #
    def update(data)
      data.each do |d|
        set_rate d[:currency], d[:rate], d[:date]
      end
      nil
    end

    NotImplementedError = Class.new(StandardError)
  end
end