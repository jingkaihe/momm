require 'spec_helper'

describe Momm::Memcached do
  context 'default configurations' do

    it 'default options should be correct' do
      Momm::Memcached::DEFAULT_OPTIONS.should == { connection: "localhost:11211", namespace: "momm", compress: true }
    end
  end

  context '#initialize' do
    it 'can be initialized without params passed in' do
        momm = Momm::Memcached.new
        momm.client.should be_a(Dalli::Client)
    end

    it 'can be initialized' do
      momm = Momm::Memcached.new connection: '127.0.0.1:12345'
      momm.client.should be_a(Dalli::Client)
    end
  end

  context '#set & #get' do
    it 'can set and get' do
      momm = Momm::Memcached.new

      money = rand(20)
      momm.set_rate :USD, money
      momm.get_rate(:USD).should == money
    end
  end
end