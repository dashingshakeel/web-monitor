class SessionsController < ApplicationController
  def new
    if !current_user.nil?
      redirect_to root_url
    end
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      login user
      redirect_to user
    else
      flash[:danger] = 'Invalid  Email /password combination'
      render 'new'
      
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
