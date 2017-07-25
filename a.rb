

require 'timeout'
require 'socket'

class Ping 
  def self.pingecho(host, timeout=5, service="echo")
    begin
      Timeout::timeout(timeout) do
        s = TCPSocket.new(host, service)
        s.close
      end
    rescue Errno::ECONNREFUSED
      return true
    rescue   Timeout::Error, StandardError 
      return false 
    end
    return true
  end

end




def port_open?(ip, port, seconds=1)
  Timeout.timeout(seconds) do
    begin
      TCPSocket.new(ip, port).close
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
      false
    end
  end
rescue Timeout::Error
  false
end
puts port_open?("https://github.com",80)