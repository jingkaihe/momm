require 'spec_helper'

describe Momm do
  context "Calculator delegation" do
    it "should respond to exchange_rate" do
      expect(Momm).to respond_to :exchange_rate
    end

    it "should respond to exchange" do
      expect(Momm).to respond_to :exchange
    end

    it "should respond to update!" do
      expect(Momm).to respond_to :update!
    end
  end

  describe "bridge delegation" do
    it "should be successfully switch to redis store halfway" do
      Momm.store :redis_store
      expect(Momm.send(:calculator).storage.client).to be_a(Redis::Namespace)
      Momm.store :memcached
    end

    it "should be successfully switch to ECB halfway" do
      Momm.source :ECB
      expect(Momm.send(:calculator).feed).to be_a(Momm::Feeds::ECB)
    end
  end

  describe ".setup" do
    it "can config" do
      Momm.setup do
        store :redis_store
      end

      expect(Momm.send(:calculator).storage).to be_a(Momm::RedisStore)
      expect(Momm.send(:calculator).feed).to be_a(Momm::Feeds::ECB)

      Momm.store :memcached
    end
  end
end
