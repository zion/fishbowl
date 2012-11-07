require 'spec_helper'

describe Fishbowl::Connection do
  let(:connection) { Fishbowl::Connection.new(host: 'localhost') }

  describe '.new' do
    it 'should require a host' do
      lambda { Fishbowl::Connection.new() }.should raise_error(Fishbowl::Errors::MissingHost)
    end

    it 'should default to port 28192' do
      connection.port.should eq(28192)
    end
  end

  describe '#login' do
    it 'should require a username' do
      lambda { connection.login(password: 'secret') }.should raise_error(Fishbowl::Errors::MissingUsername)
    end

    it 'should require a password' do
      lambda { connection.login(username: 'johndoe') }.should raise_error(Fishbowl::Errors::MissingPassword)
    end

    it 'should connect to Fishbowl API' do
      pending
    end
  end

  describe '#close' do
    pending
  end
end
