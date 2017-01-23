class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 255 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
		format: {with: VALID_EMAIL_REGEX},
		uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, confirmation: true, allow_nil: true
	validates :document, presence: true
	validates :plan_id, presence: true
	validates :lessons, presence: true

	
	#has_and_belongs_to_many :schedule
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/img/anon_user.png"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

	has_many :schedules, dependent: :destroy
	has_many :events
	belongs_to	 :plan
	has_many 	:points
	def User.digest(string)
	    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
	                                                  BCrypt::Engine.cost
	    BCrypt::Password.create(string, cost: cost)
  	end
  	
  	def User.new_token
    	SecureRandom.urlsafe_base64
  	end
end