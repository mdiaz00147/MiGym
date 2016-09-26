class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  
  def index
    @lessons = Lesson.all.order(start_date: :desc)
    auth = {:username => "elite_fitness", :password => "3li73Services+-*"}
    @blah = HTTParty.get("http://services.dynash.com/index.php/users/sessionsatdate/", 
                     :basic_auth => auth)

  end
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit

  end
  def create
    @lesson   = Lesson.new(lesson_params)
      if @lesson.save
        flash[:success] = "Clase creada existosamente"
        redirect_to lessons_path
      else
        flash[:warning] = @lesson.errors
        redirect_to  lessons_path
      end
  
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
      if @lesson.update(lesson_params)
        flash[:success] = "Clase actualizada existosamente"
        redirect_to lessons_path
      else
        flash[:warning] = @lesson.errors
        redirect_to  lessons_path
      end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    flash[:danger] = "Clase eliminada"
    redirect_to lessons_path
  end
  def multiply
    @lessons  = Lesson.where(start_date: (Time.zone.now.beginning_of_week.beginning_of_day)..Time.zone.now.end_of_week.end_of_day)
    @lessons.each do |newl|
      @new_lesson_date  = (newl.start_date) + 1.weeks
      @check  = Lesson.where(start_date: @new_lesson_date)
      if !@check.present?
        @new_lesson       = Lesson.new(start_date: @new_lesson_date, 
                                       users_allowed: newl.users_allowed, 
                                       name: newl.name, 
                                       description: newl.description, 
                                       users_enrolled: 0)
        @new_lesson.save
      end
    end
    flash[:success] = "Semana actualizada!!!"
    redirect_to lessons_path
  end

  private
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end
    def lesson_params
      params.require(:lesson).permit(:users_allowed, :name, :start_date, :description)
    end
end



class Dynash
  response = HTTParty.get('http://services.dynash.com/index.php/users/listactive')

  include HTTParty
  base_uri 'http://services.dynash.com/'

  def initialize(u, p)
    @auth = {username: u, password: p}
  end

  def lessons
    self.class.get("/index.php/users/listactive")
  end


end

