class PointsController < ApplicationController
	before_action	:set_user, only: 	[:user_points]
	def new
		@user	=	User.all.select(:id,:name)
		@points =	Point.all.order(id: :desc)
	end
	def create
		no_points	=	params[:points][:number_points].to_i
		valid_thru	=	DateTime.now.end_of_day.end_of_month.to_formatted_s(:db) 
		# return render json: valid_thru.to_formatted_s(:db) 
		no_points.times do |points|
			new_points	=	Point.new(set_points)
			new_points.valid_thru	=	valid_thru
			new_points.save
		end
		flash[:success]	=	'Puntos asignados correctamente'
		redirect_to puntos_path
	end
	def destroy
		point_id	=	Point.find(params[:id])
		if point_id.destroy
			flash[:warning]	=	'Punto eliminado correctamente'
			redirect_to request.referer
		end

	end
	def user_points
		
	end
private
	def set_user
		@user 	=	User.find(params[:id])
	end
	def set_points
		params.require(:points).permit(:user_id)
	end
end
