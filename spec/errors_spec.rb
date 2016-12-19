require 'spec_helper'
require 'yaml'

describe Fishbowl::Errors do
  describe '.confirm_success_or_raise' do
    it "should return true is code is 1000" do
      expect(Fishbowl::Errors.confirm_success_or_raise('1000')).to eql true
    end

    # it "should raise an error on any other code" do
    #   statuses = YAML.load_file('./lib/status_codes.yml')['codes']
    #   status_codes = statuses.values.map{|sc| sc["code"]} - [1000]
    #   1.times do
    #     code = status_codes.sample
    #     expect(Fishbowl::Errors.confirm_success_or_raise(code)).to raise_error(Exception.new "My error")
    #     # expect(Fishbowl::Errors.confirm_success_or_raise(code)).to raise_error(StatusError, status[code]['message'])
    #   end
    # end
  end
end
