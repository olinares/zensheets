require 'rails_helper'

describe 'Hash' do
  let(:x) { { :a => 1, :b => 2 } }
  let(:y) { { :b => 2, :a => 1 } }

  it "should be equal with ==" do
    x.should == y
  end
end
