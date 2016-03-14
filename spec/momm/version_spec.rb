require 'spec_helper'

describe 'momm version' do
  it 'should be correct' do
    expect(Momm::VERSION).to eq '0.0.7'
  end
end
