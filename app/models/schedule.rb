class Schedule < ActiveRecord::Base
	#has_many :lessons, dependent: :destroy

	belongs_to :user
	belongs_to :lesson
	#has_one :lesson
end
