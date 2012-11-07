require 'socket'
require 'rspec/mocks'

TCP_NEW = TCPSocket.method(:new) unless defined? TCP_NEW

#
# Example:
#   mock_tcp_next_request("<xml>junk</xml>")
#
class FakeTCPSocket
  def readline(some_text = nil)
    return @canned_response
  end

  def flush
  end

  def write(some_text = nil)
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
    FakeTCPSocket.new
  }
end

def mock_tcp_next_request(string)
  TCPSocket.stub!(:new).and_return {
    cm = FakeTCPSocket.new
    cm.set_canned(string)
    cm
  }
end

def unmock_tcp
  TCPSocket.stub(:new).and_return { TCP_NEW.call }
end
