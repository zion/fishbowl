require 'spec_helper'

describe Fishbowl::Connection do
  before :each do
    mock_tcp_connection
  end

  after :each do
    unmock_tcp
  end

  describe '.connect' do
    it 'should require a host' do
      lambda { Fishbowl::Connection.connect }.should raise_error(Fishbowl::Errors::MissingHost)
    end

    it 'should default to port 28192' do
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.port.should eq(28192)
    end
  end

  describe '.login' do
    it 'should require a username' do
      lambda { Fishbowl::Connection.login(password: 'secret') }.should raise_error(Fishbowl::Errors::MissingUsername)
    end

    it 'should require a password' do
      lambda { Fishbowl::Connection.login(username: 'johndoe') }.should raise_error(Fishbowl::Errors::MissingPassword)
    end

    it 'should connect to Fishbowl API' do
      pending
    end
  end

  describe '#close' do
    pending
  end
end
