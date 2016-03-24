require "sinatra/base"
require "momm"
require "erb"
require "json"
module Momm
  class Web < ::Sinatra::Base

    set :root, File.expand_path(File.dirname(__FILE__) + "/../../vendor")
    set :public_folder, Proc.new { "#{root}/assets" }
    set :views, Proc.new { "#{root}/views" }

    # GET '/'
    # == Returns
    # the index page
    #
    get '/' do
      @currencies = Momm.currencies
      erb :index
    end

    # GET '/query'
    #
    # == Params
    # money, from, to, date
    #
    # == Returns
    # exchanged money
    #
    get '/query' do
      content_type :json

      money = params[:money].to_f
      from = (params[:from] || "GBP").to_sym
      to = (params[:to] || "GBP").to_sym
      date = params[:date] || Date.today

      rate = if money && from && to && date
        Momm.exchange(money, from, to, date: date)
      else
        "N/A"
      end

      {rate: rate}.to_json
    end

    # GET '/currencies'
    #
    # == Returns
    # the currencies available
    #
    get '/currencies' do
      content_type :json
      Momm.currencies.to_json
    end

    def root_path
      "#{env['SCRIPT_NAME']}"
    end
  end
end
