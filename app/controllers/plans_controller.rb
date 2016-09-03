class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  def index
    @plans = Plan.all
  end

  def show
  end

  def new
    @plan = Plan.new
  end
  def edit
  end

  def create
    @plan = Plan.new(plan_params)

      if @plan.save
        flash[:success] = "Plan creado exitosamente"
        redirect_to plans_path
      else
        flash[:success] = @plan.errors
        redirect_to plans_path
      end
  end
  def update
      if @plan.update(plan_params)
        flash[:success] = "Plan editado exitosamente"
        redirect_to plans_path
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
  end
  def destroy
    @plan.destroy
    flash[:danger] = "Plan eliminado correctamente"
    redirect_to plans_path
  end

  private
    def set_plan
      @plan = Plan.find(params[:id])
    end
    def plan_params
      params.require(:plan).permit(:name, :lessons, :price, :start_hour, :end_hour)
    end
end
