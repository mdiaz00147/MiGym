class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to current_user
    end
  end
  def create
  	 user = User.find_by(email: params[:session][:email].downcase)
     user.update_attribute(:last_login, DateTime.now)
    if user && user.authenticate(params[:session][:password])
      log_in user
      Gymail.register_email(user).deliver_now

        


      flash[:success] = "Bienvenido de nuevo #{current_user.name.upcase}"
      redirect_to user
    else
      flash[:danger] = 'Email invalido/Contrasena incorrecta' # Not quite right!
      render 'new'
    end
    
  end
  def destroy
    log_out
    redirect_to root_url
  end
end