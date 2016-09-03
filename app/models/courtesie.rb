class Courtesie < ActiveRecord::Base
	validates :name, presence: true
	validates :phone, presence: true
	validates :start_hour, presence: true

end
