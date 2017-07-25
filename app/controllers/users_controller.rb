class UsersController < ApplicationController
  before_filter :validate_user,:only => :show
  def new
    if current_user.nil?

      @user = User.new(user_params)
    else
      redirect_to root_path
    end
  end
  def show
    @user = User.find(params[:id]) 
    @supervisors = @user.supervisors
    @supervisor = Supervisor.new(supervisor_params)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      flash[:success] = "welcome to page"

      redirect_to @user
    else
      render 'new'
    end
  end


  private

    def user_params
      params.fetch(:user,{}).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    def validate_user
      if !current_user.nil?
        redirect_to root_path unless current_user.id.to_s == params[:id]
      else
        redirect_to root_path
      end
      
      
    end
    def supervisor_params
      params.fetch(:supervisor,{}).permit(:name,:url)
    end
   
      

end
