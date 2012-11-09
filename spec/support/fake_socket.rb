require 'socket'
require 'singleton'
require 'rspec/mocks'

TCP_NEW = TCPSocket.method(:new) unless defined? TCP_NEW

class FakeTCPSocket
  include Singleton

  attr_reader :last_write

  def flush; end

  def write(some_text = nil)
    @last_write = some_text
  end

  def readchar
    6
  end

  def read(num)
    set_canned('') if @canned_response.nil?
    num > @canned_response.size ? @canned_response : @canned_response.slice!(0..num)
  end
  alias_method :recv, :read

  def set_canned(response)
    body = response
    size = [body.size].pack("L>")

    @canned_response = size + body
  end

  def close; end
end

def mock_tcp_connection
  TCPSocket.stub(:new).and_return {
    FakeTCPSocket.instance
  }
end

def unmock_tcp
  TCPSocket.stub(:new).and_return { TCP_NEW.call }
end
