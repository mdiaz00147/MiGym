class Schedule < ActiveRecord::Base
	#has_many :lessons, dependent: :destroy
	belongs_to :user
	belongs_to :lesson
	#has_one :lesson
	# belongs_to :courtesie
	has_one :courtesie
end
