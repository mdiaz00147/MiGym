class EventsController < ApplicationController
	def referer
		phone_1 	 = params[:referer][:phone_1]
		name_1 		 = params[:referer][:name_1]
		phone_2 	 = params[:referer][:phone_2]
		name_2 		 = params[:referer][:name_2]
		phone_3 	 = params[:referer][:phone_3]
		name_3 		 = params[:referer][:name_3]

		if name_1.empty? || name_2.empty? || name_3.empty?
		   phone_1.empty? || phone_2.empty? || phone_3.empty?
			flash[:warning] = "Recuerda que deben ser mínimo 3 referidos"
			redirect_to current_user 
		else
			@referer_1 = Event.new(event_name: params[:referer][:event_name],
									 option_1: name_1,
									 option_2: phone_1,
									 user_id: current_user.id)
			if @referer_1.save
			@referer_2 = Event.new(event_name: params[:referer][:event_name],
									 option_1: name_2,
									 option_2: phone_2,
									 user_id: current_user.id)
			end
			if @referer_2.save
			@referer_3 = Event.new(event_name: params[:referer][:event_name],
									 option_1: name_3,
									 option_2: phone_3,
									 user_id: current_user.id)
			end
			if @referer_3.save
				flash[:success] = "Inscrito correctamente :)"
				redirect_to current_user
			end
		end

	end
	def index
		@event = Event.all.order(id: :asc)
		
	end
	def reminder
		@user = User.where("last_login < '#{(Time.now) -1.weeks}'")
		@user.each do |userReminder|
		if !userReminder.last_email.blank?
			if Date.parse(userReminder.last_email.to_s) != Date.parse(Time.now.to_s)
				if Date.parse(userReminder.last_email.to_s) < Date.parse(((Time.now) -3.days).to_s)
					Gymail.reminder(userReminder).deliver_now
					userReminder.update_attribute(:last_email, DateTime.now)
				end
			end
		else
			Gymail.reminder(userReminder).deliver_now
			userReminder.update_attribute(:last_email, DateTime.now)
		end
			
		end
		redirect_to current_user
	end
end
