class StatsController < ApplicationController
	def index
	@user		  		=	User.find(current_user.id)
	@schedules    		= 	@user.schedules
	@schedules_month    = 	@user.schedules.where(created_at: (Time.now.beginning_of_month)..Time.now.end_of_month)
	end
	
end
