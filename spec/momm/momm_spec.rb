require 'spec_helper'

describe Momm do
  context "Calculator delegation" do
    it "should respond to exchange_rate" do
      Momm.should respond_to :exchange_rate
    end

    it "should respond to exchange" do
      Momm.should respond_to :exchange
    end

    it "should respond to exchange_from_gbp_to_usd" do
      Momm.should respond_to :exchange_from_gbp_to_usd
    end

    it "should respond to exchange_rate_from_gbp_to_usd" do
      Momm.should respond_to :exchange_rate_from_gbp_to_usd
    end

    it "should respond to update!" do
      Momm.should respond_to :update!
    end
  end

  context ".store" do
    it "should be successfully switch to redis store halfway" do
      Momm.store :redis_store
      Momm.send(:calculator).storage.client.should be_a(Redis::Namespace)
      Momm.store :memcached
    end
  end
end