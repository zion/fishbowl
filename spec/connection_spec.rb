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
      lambda {
        Fishbowl::Connection.connect
      }.should raise_error(Fishbowl::Errors::MissingHost)
    end

    it 'should default to port 28192' do
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.port.should eq(28192)
    end
  end

  describe '.login' do
    before :each do
      Fishbowl::Connection.connect(host: 'localhost')
    end

    it 'should require the connection to be established' do
      lambda {
        Fishbowl::Connection.close
        Fishbowl::Connection.login
      }.should raise_error(Fishbowl::Errors::ConnectionNotEstablished)
    end

    it 'should require a username' do
      lambda {
        Fishbowl::Connection.login(password: 'secret')
      }.should raise_error(Fishbowl::Errors::MissingUsername)
    end

    it 'should require a password' do
      lambda {
        Fishbowl::Connection.login(username: 'johndoe')
      }.should raise_error(Fishbowl::Errors::MissingPassword)
    end

    it 'should connect to Fishbowl API' do
      mock_login_response
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end
  end

  describe '.close' do
    it "should close the connection" do
      lambda {
        mock_login_response
        Fishbowl::Connection.connect(host: 'localhost')
        Fishbowl::Connection.login(username: 'johndoe', password: 'secret')

        Fishbowl::Connection.close
        Fishbowl::Connection.login
      }.should raise_error(Fishbowl::Errors::ConnectionNotEstablished)
    end
  end

  describe '.host' do
    it 'should return the host value' do
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.host.should eq('localhost')
    end
  end

  describe '.port' do
    it "should return the port value" do
      Fishbowl::Connection.connect(host: 'localhost', port: 1234)
      Fishbowl::Connection.port.should eq(1234)
    end
  end

  describe '.username' do
    it 'should return the username value' do
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
      Fishbowl::Connection.username.should eq('johndoe')
    end
  end

  describe '.password' do
    it 'should return the password value' do
      mock_login_response
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
      Fishbowl::Connection.password.should eq('secret')
    end
  end
end
