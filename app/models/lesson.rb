class Lesson < ActiveRecord::Base
	validates	:name, presence: true
	validates	:start_date, presence: true 
	validates	:users_allowed, presence: true
	belongs_to 	:user


	def expiry_date_cannot_be_in_the_past
  		errors.add(:start_date, "Date must be higher or equal to today") if :start_date < Date.today
	end
end
