class SupervisorsController < ApplicationController
  before_action :set_supervisor, only: [:show, :edit, :update, :destroy]

  # GET /supervisors
  # GET /supervisors.json
  def index
    @supervisors = Supervisor.all
  end

  # GET /supervisors/1
  # GET /supervisors/1.json
  def show
    @supervisor = Supervisor.find(params[:id])

    @services = Service.where(supervisor_id: @supervisor.id )

  end

  # GET /supervisors/new
  def new
    @supervisor = Supervisor.new
  end

  # GET /supervisors/1/edit
  def edit
  end

  # POST /supervisors
  # POST /supervisors.json
  def create
    @supervisor = current_user.supervisors.build(supervisor_params)
   
    respond_to do |format|
      if @supervisor.save
        format.html { redirect_to current_user, notice: 'Supervisor was successfully created.' }
        format.json { render :show, status: :created, location: @supervisor }
      else
        format.html { render :new }
        format.json { render json: @supervisor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supervisors/1
  # PATCH/PUT /supervisors/1.json
  def update
    respond_to do |format|

    @user = User.find(current_user.id)
      if @supervisor.update(supervisor_params)
        format.html { redirect_to @user, notice: 'Supervisor was successfully updated.' }
        format.json { render :show, status: :ok, location: @supervisor }
      else
        format.html { render :edit }
        format.json { render json: @supervisor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supervisors/1
  # DELETE /supervisors/1.json
  def destroy

    @user = User.find(current_user.id)
    @supervisor.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: 'Supervisor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supervisor
      @supervisor = Supervisor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supervisor_params
      params.require(:supervisor).permit(:name,:url,:user_id)
    end
    def service_params
      params.fetch(:service,{}).permit(:type_id, :port,:duration, :start_time, :end_time)
    end
end
