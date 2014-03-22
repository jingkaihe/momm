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
  end
end