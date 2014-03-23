require 'spec_helper'

require 'momm/web'
require 'rack/test'

describe Momm::Web do
  include Rack::Test::Methods

  def app
    Momm::Web
  end

  it 'should response' do
    get '/query', money: 12, from: "GBP", to: "USD", date: "2014-3-10"

    expect(last_response).to be_ok
    expect(last_response.body).to eq("19.98")
  end
end
