class RequestWorkers
   include Sidekiq::Worker
   require "net/http"
   require "uri"
   require 'socket'
   require 'timeout'
   require 'net/ping'



  def up?(host)
    check = Net::Ping::External.new(host)
    check.ping?
  end


 # prints "true" if ping replies

  def is_port_open?(ip, port)
    begin
      Timeout::timeout(1) do
        begin
          s = TCPSocket.new(ip, port)
          s.close
          return true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          return false
        end
      end
    rescue Timeout::Error
    end

    return false
  end


  def perform(supervisor_id,service_id,type_id,start_time,end_time,duration, port,current_user, url)
    puts "start"
    
     
       while true do

         while true  do
            if type_id == 1
              uri = URI.parse('http://'+url)
              http = Net::HTTP.new(uri.host, uri.port)
              request = Net::HTTP::Get.new(uri.request_uri)
              start_time = Time.now
              response = http.request(request)
              responset = Time.now - start_time 

              puts responset 
              puts l = response.code 

              a = Log.new(user_id: current_user,supervisor_id: supervisor_id, service_id: service_id,type_id: type_id,status: l, response_time: esl)
              a.save
              puts "done"
              sleep 30
            end
            if type_id == 3
              start_time = Time.now
              puts l = up?(url)
              responset = Time.now - start_time
              if l == 'true'
                ping = 'pong'
              else
                ping = 'no pong'
              end
              a = Log.new(user_id: current_user,supervisor_id: supervisor_id, service_id: service_id,type_id: type_id, status: ping, response_time: responset)
              a.save 
             sleep 30
            end
            if type_id == 2
              start_time = Time.now 
              puts l = is_port_open?(url, port) 
              responset = Time.now - start_time
              if l == true
                port = 'open'
              else
                port = 'not open'
              end
              a = Log.new(user_id: current_user,supervisor_id: supervisor_id, service_id: service_id,type_id: type_id,status: port, response_time: responset)
              a.save  
              sleep 60
            end

        end
        sleep  24.hours

      end
        
    
    
  end
end 