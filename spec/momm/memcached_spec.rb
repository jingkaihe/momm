require 'spec_helper'

describe Momm::Memcached do
  context 'default configurations' do

    it 'default options should be correct' do
      expect(Momm::Memcached::DEFAULT_OPTIONS).to eq({
        connection: "localhost:11211",
        namespace: "momm",
        compress: true
      })
    end
  end

  context '#initialize' do
    it 'can be initialized without params passed in' do
        momm = Momm::Memcached.new
        expect(momm.client).to be_a(Dalli::Client)
    end

    it 'can be initialized' do
      momm = Momm::Memcached.new connection: '127.0.0.1:12345'
      expect(momm.client).to be_a(Dalli::Client)
    end
  end

  context '#set & #get' do
    it 'can set and get' do
      momm = Momm::Memcached.new

      money = rand(20)
      momm.set_rate :USD, money
      expect(momm.get_rate(:USD)).to eq money

      Momm.update!
    end
  end
end
