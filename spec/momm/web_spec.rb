require 'spec_helper'

require 'momm/web'
require 'rack/test'

describe Momm::Web do
  include Rack::Test::Methods

  def app
    Momm::Web
  end

  describe 'GET /' do
    it 'should response' do
      get '/'
      expect(last_response).to be_ok
    end
  end

  describe 'GET /query' do
    it 'should response' do
      get '/query', money: 12, from: "GBP", to: "USD", date: "2014-3-10"

      expect(last_response).to be_ok
      expect(last_response.body).to eq("19.92")
    end
  end

  describe 'GET /currencies' do
    it 'should response' do
      get '/currencies'

      expect(last_response).to be_ok

      expect(JSON.parse(last_response.body)).to be_a Array
    end
  end
end
