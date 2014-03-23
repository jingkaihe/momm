require 'spec_helper'

describe Momm::RedisStore do
  context 'default configurations' do
    it 'default options should be correct' do
      Momm::RedisStore::DEFAULT_OPTIONS.should == {
        host: "localhost", port: 6379, namespace: "momm"
      }
    end
  end

  context '#initialize' do
    it 'can be initialized without params passed in' do
        momm = Momm::RedisStore.new
        momm.client.should be_a(Redis::Namespace)
    end

    it 'can be initialized' do
      momm = Momm::RedisStore.new host: "localhost",
        port: 6379, namespace: "momm"
      momm.client.should be_a(Redis::Namespace)
    end
  end

  describe '#set & #get' do
    it 'can set and get' do
      calc = Momm::Calculator.new Momm::RedisStore.new

      money = rand(20)

      calc.set_rate :USD, money
      calc.get_rate(:USD).should == money

      Momm.update!
    end
  end
end