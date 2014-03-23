require 'httparty'
require 'open-uri'

module Momm
  module Feeds
    class ECB

      FETCHING_URL = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml".freeze

      #Hard coded for good
      CURRENCIES = %w{USD JPY BGN CZK DKK GBP HUF LTL PLN RON SEK CHF
        NOK HRK RUB TRY AUD BRL CAD CNY HKD IDR ILS INR KRW
        MXN MYR NZD PHP SGD THB ZAR}.freeze

      class << self

        # Eager loading the instance of ECB
        #
        # == Returns
        # self
        #
        def instance
          @instance ||= self.send :new
        end
      end

      # should be a singleton class
      private_class_method :new

      # Parse the XML data by Nokogiri
      # == Returns
      # Nokogiri Object
      #
      def parsed_content
        # @TODO Refactoring Bad patterns
        HTTParty.get(fetching_url, format: :xml)['Envelope']['Cube']['Cube']
      end

      # convert the nokogiri parsed data to array
      #
      # == Returns
      # looks like [{date: Date.now, currency: :CNY, rate: 1.23} ...]
      #
      def currency_rates
        parsed_content.map do |content|
          date = Date.parse(content["time"])
          cubes = content["Cube"]
          cubes.map do |cube|
            {
              date: date,
              currency: cube["currency"].to_sym,
              rate: cube["rate"].to_f
            }
          end
        end.flatten
      end

      def fetching_url
        FETCHING_URL
      end

      def currencies
        CURRENCIES
      end
    end
  end
end