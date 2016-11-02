class Courtesie < ActiveRecord::Base
	validates :name, presence: true
	validates :phone, presence: true
	validates :start_hour, presence: true
	# belongs_to 	:schedule
	belongs_to 	:schedule
end
