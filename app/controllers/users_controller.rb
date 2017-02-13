class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :admin_edit]
  #before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :check_login

  def show
  	@user         = User.find(params[:id])
    @schedules    = @user.schedules.where(created_at: (Time.now.beginning_of_month)..Time.now.end_of_month)
    @event        = @user.events.all
    @plan         = @user.plan
    @plans        = Plan.all
  end
  
  def index
    @users  =  User.all
  end
  def new
    @user         = User.new
    @plans        = Plan.all
  end
  def edit
    @plans        = Plan.all
  end
  def admin_edit
    @plans        = Plan.all
  end

  def create
    plan        =   params[:user][:plan_id]
    expiry      =   (Time.now + 1.months) 
    @plan_vars   =   Plan.find(plan)

  	@user        = User.new(user_params)
    @user.plan_id   = @plan_vars.id
    @user.lessons   = @plan_vars.lessons
    @user.expiry_at = expiry

      if @user.save
      	flash[:success] = "Usuario creado exitosamente"
        Gymail.register_email(@user).deliver_now
        redirect_to	users_path
      else
        @plans        = Plan.all
      	render 'new'
      end
  end

  def update
    # return render json: params[:user][:plan_id]
    @plans  = Plan.all
    posted_expiration  = params[:user][:expiry_at]
    posted_expiration ? (
      expiration    = Date.strptime(posted_expiration,'%m/%d/%Y')
      @user.expiry_at = expiration
      ) : ()
      if @user.update(user_params)
        flash[:success] = "Actualizado correctamente"
        redirect_to request.referer
      else
        @user = User.find(params[:id])
        render 'edit'
      end
  end
  def destroy
    @user.destroy
    flash[:warning] = "Usuario eliminado"
    redirect_to users_path
  end
  private
    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:name, :email, :phone, :document, :password,
                                   :password_confirmation, :plan_id, :lessons, :avatar)
    end
    def check_login
      if !logged_in?
        flash[:danger] = "Por favor inicia sesion"
        redirect_to root_path
      end
    end
     def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

