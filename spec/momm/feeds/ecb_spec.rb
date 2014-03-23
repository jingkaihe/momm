require 'spec_helper'

describe Momm::Feeds::ECB do
  context '#initialize' do
    it "cannot call new method do" do
      expect{
        Momm::Feeds::ECB.new
      }.to raise_error
    end

    it "should eager loading the ECB instance" do
      instance1 = Momm::Feeds::ECB.instance
      instance2 = Momm::Feeds::ECB.instance
      instance1.object_id.should == instance2.object_id
    end
  end

  describe ".currencies" do
    it 'should not be nil' do
      Momm::Feeds::ECB.instance.currencies.should be_a(Array)
    end
  end

  describe "#fetching_url" do
    it 'should not be nil' do
      Momm::Feeds::ECB.instance.fetching_url.should be_a String
    end
  end

  describe "#currency_rates" do
    let(:rates) { Momm::Feeds::ECB.instance.currency_rates }
    it 'should be an array' do
      rates.should be_a Array
    end

    it 'should contain several elements' do
      rates.length.should > 0
    end

    it 'should contain :date, :currency and :rates' do
      rates.all?{
        |rate| rate.has_key?(:date) &&
        rate.has_key?(:currency) &&
        rate.has_key?(:rate)
      }.should be_true
    end
  end
end