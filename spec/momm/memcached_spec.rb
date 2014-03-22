require 'spec_helper'

describe Momm::Memcached do
  context 'default configurations' do
    it 'default connection should be correct' do
      Momm::Memcached::DEFAULT_CONNECTION.should == "localhost:11211"
    end

    it 'default options should be correct' do
      Momm::Memcached::DEFAULT_OPTIONS.should == { namespace: "momm", compress: true }
    end
  end

  context '#initialize' do
    it 'can be initialized without params passed in' do
        momm = Momm::Memcached.new
        momm.client.should be_a(Dalli::Client)
    end

    it 'can be initialized' do
      momm = Momm::Memcached.new '127.0.0.1:12345'
      momm.client.should be_a(Dalli::Client)
    end
  end

  context '#set & #get' do
    it 'can set and get' do
      momm = Momm::Memcached.new

      momm.set_rate Date.today, :USD, 1.23
      momm.get_rate(Date.today, :USD).should == 1.23
    end
  end

  context '#exchange_rate' do
    momm = Momm::Memcached.new

    momm.set_rate Date.today, :USD, 1.23
    momm.set_rate Date.today, :JPY, 12.4

    momm.exchange_rate(:USD, :JPY).should == 12.4 / 1.23
  end
end