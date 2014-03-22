require 'spec_helper'

describe Momm::Calculator do

  context 'redis store' do
    describe '#client' do
      it 'should response to client' do
        calc = Momm::Calculator.new Momm::RedisStore.new
        calc.should respond_to :client
      end
    end
  end

  context 'memcached store' do
    describe '#client' do
      it 'should response to client' do
        calc = Momm::Calculator.new
        calc.should respond_to :client
      end
    end
  end
end