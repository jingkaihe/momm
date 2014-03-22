require "spec_helper"

describe Momm::Storage do
  let(:storage) { Momm::Storage.new }

  context "NotImplementedError" do
    it "should apply to #client" do
      expect{
        storage.client
      }.to raise_error
    end

    it "should apply to #set_rate" do
      expect{
        storage.set_rate
      }.to raise_error
    end

    it "should apply to #get_rate" do
      expect{
        storage.get_rate
      }.to raise_error
    end

    it "should apply to #exchange_rate" do
      expect{
        storage.client
      }.to raise_error
    end

    it "should apply to #exchange_rate" do
      expect{
        storage.client
      }.to raise_error
    end
  end
end