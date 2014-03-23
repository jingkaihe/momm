require 'sinatra/base'
require 'momm'

module Momm
  class Web < ::Sinatra::Base
    get '/query' do
      content_type :json

      money = params[:money].to_f
      from = params[:from].to_sym
      to = params[:to].to_sym
      date = params[:date]


      if money && from && to && date
        Momm.exchange(money, from, to, date: date).to_json
      else
        "N/A"
      end

    end
  end
end