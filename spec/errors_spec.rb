require 'spec_helper'

describe Fishbowl::Errors do
  describe '.confirm_success_or_raise' do
    it "should return true is code is 1000" do
      Fishbowl::Errors.confirm_success_or_raise('1000', '').should be_true
    end

    it "should raise an error on any other code" do
      10.times do
        code = rand(3004) + 1000
        lambda {
          Fishbowl::Errors.confirm_success_or_raise(code, '')
        }.should raise_error(Fishbowl::Errors::StatusError)
      end
    end
  end
end
