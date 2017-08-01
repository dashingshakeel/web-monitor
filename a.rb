

require 'timeout'
require 'socket'
 require "net/http"
   require "uri"
   require 'socket'
   require 'timeout'
   require 'net/ping'



require 'net/ping'

def up?(host)
    check = Net::Ping::External.new(host)
    check.ping?
end

chost = 'facebook.com'
puts up?(chost) # prints "true" if ping replies

uri = URI.parse('http://facebook.com')
              http = Net::HTTP.new(uri.host, uri.port)
              request = Net::HTTP::Get.new(uri.request_uri)
              start_time = Time.now
              response = http.request(request)
              responset = Time.now - start_time 

              
              puts l = response.code 
