require 'spec_helper'

describe Momm::Bridge do
  describe '#initialize' do
    it 'should have default' do
      bridge = Momm::Bridge.new

      bridge.storage.should be_a(Momm::Memcached)
      bridge.feed.should be_a(Momm::Feeds::ECB)
    end
  end

  describe '#store' do
    let(:bridge) { Momm::Bridge.new }

    it 'should change the storage' do
      bridge.store :redis_store
      bridge.storage.should be_a(Momm::RedisStore)
    end

    it 'should change the ECB' do
      bridge.source :ECB
      bridge.feed.should be_a(Momm::Feeds::ECB)
    end
  end
end