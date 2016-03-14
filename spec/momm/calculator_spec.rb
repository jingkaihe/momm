require 'spec_helper'

describe Momm::Calculator do

  context 'redis store' do
    let(:calc) { calc = Momm::Calculator.new Momm::RedisStore.new }

    it 'should response to client' do
      expect(calc).to respond_to :client
    end

    it 'should response to set_rate' do
      expect(calc).to respond_to :set_rate
    end

    it 'should response to get_rate_origin' do
      expect(calc).to respond_to :get_rate_origin
    end

    it 'should response to get_rate' do
      expect(calc).to respond_to :get_rate
    end

    it 'should response to exchange_rate' do
      expect(calc).to respond_to :exchange_rate
    end

    it 'should response to exchange' do
      expect(calc).to respond_to :exchange
    end
  end

  context 'memcached store' do
    let(:calc) { Momm::Calculator.new }

    it 'should response to client' do
      expect(calc).to respond_to :client
    end

    it 'should response to update!' do
      expect(calc).to respond_to :update!
    end

    it 'should response to set_rate' do
      expect(calc).to respond_to :set_rate
    end

    it 'should response to get_rate_origin' do
      expect(calc).to respond_to :get_rate_origin
    end

    it 'should response to get_rate' do
      expect(calc).to respond_to :get_rate
    end

    it 'should response to exchange_rate' do
      expect(calc).to respond_to :exchange_rate
    end

    it 'should response to exchange' do
      expect(calc).to respond_to :exchange
    end

    it 'should response to currencies' do
      expect(calc).to respond_to :currencies
    end
  end

  context 'feeds' do
    it 'should not be nil' do
      calc = Momm::Calculator.new
      expect(calc.feed).not_to be_nil
    end
  end
end
