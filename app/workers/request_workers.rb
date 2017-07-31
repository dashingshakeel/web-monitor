class RequestWorkers
   include Sidekiq::Worker
   require "net/http"
   require "uri"

  def perform(supervisor_id,service_id,type_id,current_user, url)
    puts "fuck"
    
      if type_id == 1
        uri = URI.parse('http://'+url)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        start_time = Time.now
        response = http.request(request)
        esl  = Time.now - start_time 

        puts esl  
        puts l = response.code 

       a = Log.new(user_id: current_user,supervisor_id: supervisor_id, service_id: service_id,type_id: type_id,status: l, response_time: esl)
       a.save
       puts "done"
      else
        puts "dodd"
      end
    
  end
end 