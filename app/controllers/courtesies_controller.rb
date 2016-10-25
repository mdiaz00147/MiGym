class CourtesiesController < ApplicationController
	before_action :check_login
	def index
		@courtesies = Courtesie.all.order(created_at: :desc)
	end
	def new
		@lessons 	= 	Lesson.all
		@courtesie 	=	Courtesie.new
	end
	def create
		datetime_params = params[:courtesie]
			year 	= datetime_params["start_hour(1i)"]
			month 	= datetime_params["start_hour(2i)"]
			day 	= datetime_params["start_hour(3i)"]
			hour 	= datetime_params["start_hour(4i)"]
			minute 	= datetime_params["start_hour(5i)"]
		@start_hour = Time.new(year, month, day, hour, minute)
		@start_hour = @start_hour.to_formatted_s(:db)

		@lesson_check 	=	Lesson.find_by(start_date: @start_hour.to_time(:utc))
		if @lesson_check.present?
			@new_courtesie 	=	Courtesie.new(courtesie_params)
			@new_schedule	=	Schedule.new()
			@new_schedule.options	=	params[:courtesie][:name]
			@new_schedule.lesson_id	=	@lesson_check.id
			@new_schedule.user_id	=	'50'
			@new_schedule.start_date =	@lesson_check.start_date
			@new_enrolled	=	@lesson_check.users_enrolled + 1
			@lesson_check.update_attribute(:users_enrolled, @new_enrolled)

			if @new_courtesie.save && @new_schedule.save
				flash[:success] = "Cortesia agendada"
				redirect_to 	cortesias_path
			end
		else
			flash[:warning]	=	"No pude encontrar clase para el dia #{@start_hour}"
			redirect_to	cortesias_path
		end
		
	end
	def show
		@courtesie = Courtesie.find(params[:id])
	end
	def delete
		@courtesie 		= params[:id]
		@find_courtesie = Courtesie.find(@courtesie)
		@find_lesson 	= Lesson.find_by(start_date: @find_courtesie.start_hour)
		@find_schedule	= Schedule.find_by(options: @find_courtesie.name)

		@new_enrolled	= @find_lesson.users_enrolled - 1
		@find_lesson.update_attribute(:users_enrolled, @new_enrolled)
		@find_schedule.destroy
		if @find_courtesie.destroy
			flash[:warning] = "Cortesia eliminada"
			redirect_to cortesias_path
		else
			flash[:warning] = "Algo ha fallado y no he podido eliminar la cortesia"
			redirect_to cortesias_path
		end
	end

private
	def courtesie_params
		params.require(:courtesie).permit(:name, :start_hour, :email, :phone)
	end
	def check_login
      if !logged_in?
        redirect_to root_path
      end
    end
end