class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to current_user
    end
  end
  def create
  	 user = User.find_by(email: params[:session][:email].downcase)
     
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "Bienvenido de nuevo #{current_user.name.upcase}"
      redirect_to user
    else
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
    
  end
  def destroy
    log_out
    redirect_to root_url
  end
end