require 'spec_helper'

describe 'momm version' do
  it 'should be correct' do
    Momm::VERSION.should == '0.0.4'
  end
end