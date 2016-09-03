class StatsController < ApplicationController
	def index
	@user		  		=	User.find(current_user.id)
	@schedules    		= 	@user.schedules
	@schedules_month    = 	@user.schedules.where(created_at: (Time.now.beginning_of_month)..Time.now.end_of_month)
	end
	def admin_index
		@users_active =	User.where(last_login: (Time.now.beginning_of_month)..Time.now.end_of_day)
		@users_total  =	User.all
		#@lessons_active	=	Lesson.where(updated_at: (Time.now.beginning_of_month)..Time.now.end_of_day)

		beginning_of_day_2	=	''

		@users_new 			=	User.where(created_at: (Time.now.beginning_of_month)..Time.now.end_of_day)
		@lessons_morning	=	Lesson.where(start_date: (Time.now.beginning_of_month.beginning_of_day)..Time.now.end_of_day, users_enrolled: (1)..10)


	    @num_morning = [] 
	    @lessons_evening = []
        @lessons_morning.each do |te|    
	        if te.start_date <   (te.start_date.beginning_of_day  + 13.hours) 
	        	@num_morning << 1
	        else
	        	@lessons_evening << 1
	        end
        end

		@courtesis_month = Courtesie.where(created_at: (Time.now.beginning_of_month)..Time.now.end_of_day)
	end
end
