class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :set_supervisor , only: [:new]
  # GET /services
  # GET /services.json
  def index
    @services = Service.all
  end

  # GET /services/1
  # GET /services/1.json
  def show
    @supervisor = Supervisor.find(params[:supervisor_id])
    @service = Service.find(params[:id])
    @logs = Log.where(service_id: @service.id)
  end

  # GET /services/new
  def new

    @all_types = Type.all
    @supervisor = Supervisor.find(params[:supervisor_id])
    @service = Service.new(service_params)
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @supervisor = Supervisor.find(params[:supervisor_id])
    
    @service = @supervisor.services.new(service_params)
    respond_to do |format|
      if @service.save
        RequestWorkers.perform_async(@supervisor.id,@service.id,@service.type.id,@service.start_time.strftime("%H%M%S"),@service.end_time.strftime("%H%M%S"),@service.duration, @service.port,current_user.id, @supervisor.url)
        format.html { redirect_to @supervisor, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { redirect_to new_supervisor_service_path(@supervisor),notice: 'Eror.' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end
    def set_supervisor
      @service = Supervisor.where(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.fetch(:service,{}).permit(:type_id, :port, :duration, :start_time, :end_time)
    end

end

