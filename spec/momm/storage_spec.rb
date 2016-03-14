require "spec_helper"

describe Momm::Storage do
  let(:storage) { Momm::Storage.new }

  context "NotImplementedError" do
    it "should apply to #client" do
      expect{
        storage.client
      }.to raise_error NotImplementedError
    end

    it "should apply to #set_rate" do
      expect{
        storage.set_rate("GBP", "USD", 0.8)
      }.to raise_error NotImplementedError
    end

    it "should apply to #get_rate" do
      expect{
        storage.get_rate("GBP", "USD")
      }.to raise_error NotImplementedError
    end

    it "should apply to #exchange_rate" do
      expect{
        storage.client
      }.to raise_error NotImplementedError
    end

    it "should apply to #exchange_rate" do
      expect{
        storage.client
      }.to raise_error NotImplementedError
    end
  end
end
