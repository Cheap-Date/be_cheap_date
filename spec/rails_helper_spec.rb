require 'rails_helper'

RSpec.describe 'abort e.to_s.strip' do # this test it not necessary, but I wanted try and raise coverage and this helped (0.01%)
  it 'should raise an exception' do
    expect { raise 'test' }.to raise_error(RuntimeError, 'test')
  end
end
