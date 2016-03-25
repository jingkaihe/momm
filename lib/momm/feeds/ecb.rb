require "net/http"
require "uri"
require "rexml/document"

module Momm
  module Feeds
    class ECB

      FEED_URL = URI("https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml").freeze

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

      ConnectionError = Class.new(StandardError)
      # should be a singleton class
      private_class_method :new

      # Request the feed and get the response
      #
      # == Returns
      # A Net::HTTPResponse response
      #
      def response
        @response ||= Net::HTTP.start(FEED_URL.host, FEED_URL.port,
          :use_ssl => FEED_URL.scheme == "https",
          :open_timeout => 5,
          :read_timeout => 5) do |http|

          http.request Net::HTTP::Get.new(FEED_URL)
        end
      end

      # Response body in xml format
      def xml
        @xml ||= begin
          raise ConnectionError unless response.is_a? Net::HTTPOK
          REXML::Document.new response.body
        end
      end

      # turn the xml data to array of currencies
      #
      # == Returns
      # looks like [{date: Date.now, currency: :CNY, rate: 1.23} ...]
      #
      def currency_rates
        daily_currencies = xml.elements["//Cube"].select{ |c| c.is_a? REXML::Element }
        daily_currencies.map do |daily_currency|
          date = Date.parse daily_currency.attributes["time"]
          daily_currency.map do |cube|
            {
              date: date,
              currency: cube.attributes["currency"].to_sym,
              rate: cube.attributes["rate"].to_f
            }
          end
        end.flatten
      end
    end
  end
end
