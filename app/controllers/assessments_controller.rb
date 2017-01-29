class AssessmentsController < ApplicationController
  before_action :set_assessment, only: [ :edit, :update, :destroy]

  # GET /assessments
  # GET /assessments.json
  def index
    @assessments = Assessment.all
  end

  # GET /assessments/1
  # GET /assessments/1.json
  def show
    @user   = User.find(params[:id])
  end

  # GET /assessments/new
  def new
    @assessment = Assessment.new
    @users  = User.select(:id,:name)
  end

  # GET /assessments/1/edit
  def edit
    @users  = User.select(:id,:name)
  end

  # POST /assessments
  # POST /assessments.json
  def create
    @assessment = Assessment.new(assessment_params)

    if @assessment.save
      flash[:success]='Valoracion asignada correctamente'
      redirect_to assessments_path
    else
      @users  = User.select(:id,:name)
      render 'new'
    end
    
  end

  # PATCH/PUT /assessments/1
  # PATCH/PUT /assessments/1.json
  def update
    if @assessment.update(assessment_params)
      flash[:success]='Valoracion editada correctamente'
      redirect_to assessments_path
    else
      flash[:warning]='Algo esta mal'
      redirect_to request.referer
    end
  
  end

  # DELETE /assessments/1
  # DELETE /assessments/1.json
  def destroy
    if @assessment.destroy
      flash[:warning]='Valoracion eliminada correctamente'
      redirect_to assessments_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assessment
      @assessment = Assessment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assessment_params
      params.require(:assessment).permit(:body_water, :body_fat, :bone, :bmi, :visceral_fat, :bmr, :muscle_mass, :metabolic_age, :weight, :user_id)
    end
end
