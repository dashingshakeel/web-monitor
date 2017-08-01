class LogsController < ApplicationController

  # GET /services
  # GET /services.json
  def index
    @service = Service.find(params[:id])
    @logs = Log.where(id: @service.id)
  end

 
 

    # Never trust parameters from the scary internet, only allow the white list through.
    

end

