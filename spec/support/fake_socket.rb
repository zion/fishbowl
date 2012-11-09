require 'socket'
require 'singleton'
require 'rspec/mocks'

TCP_NEW = TCPSocket.method(:new) unless defined? TCP_NEW

class FakeTCPSocket
  include Singleton

  attr_reader :last_write

  def readline(some_text = nil)
    return @canned_response
  end

  def flush
  end

  def write(some_text = nil)
    @last_write = some_text
  end

  def readchar
    return 6
  end

  def read(num)
    return num > @canned_response.size ? @canned_response : @canned_response[0..num]
  end

  def set_canned(response)
    @canned_response = response
  end
end

def mock_tcp_connection
  TCPSocket.stub(:new).and_return {
    FakeTCPSocket.instance
  }
end

def unmock_tcp
  TCPSocket.stub(:new).and_return { TCP_NEW.call }
end
