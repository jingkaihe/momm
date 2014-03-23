require 'spec_helper'

describe Momm::Calculator do

  context 'redis store' do
    let(:calc) { calc = Momm::Calculator.new Momm::RedisStore.new }

    it 'should response to client' do
      calc.should respond_to :client
    end

    it 'should response to set_rate' do
      calc.should respond_to :set_rate
    end

    it 'should response to get_rate_origin' do
      calc.should respond_to :get_rate_origin
    end

    it 'should response to get_rate' do
      calc.should respond_to :get_rate
    end

    it 'should response to exchange_rate' do
      calc.should respond_to :exchange_rate
    end

    it 'should response to exchange' do
      calc.should respond_to :exchange
    end
  end

  context 'memcached store' do
    let(:calc) { Momm::Calculator.new }

    it 'should response to client' do
      calc.should respond_to :client
    end

    it 'should response to update!' do
      calc.should respond_to :update!
    end

    it 'should response to set_rate' do
      calc.should respond_to :set_rate
    end

    it 'should response to get_rate_origin' do
      calc.should respond_to :get_rate_origin
    end

    it 'should response to get_rate' do
      calc.should respond_to :get_rate
    end

    it 'should response to exchange_rate' do
      calc.should respond_to :exchange_rate
    end

    it 'should response to exchange' do
      calc.should respond_to :exchange
    end

    it 'should response to currencies' do
      calc.should respond_to :currencies
    end
  end

  context 'feeds' do
    it 'should not be nil' do
      calc = Momm::Calculator.new
      calc.feed.should_not be_nil
    end
  end
end