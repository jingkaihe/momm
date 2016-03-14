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
      get '/query', money: 12, from: "GBP", to: "USD", date: Date.today

      expect(last_response).to be_ok
      expect{
        last_response.body.to_i
      }.not_to raise_error
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
