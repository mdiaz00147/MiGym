class User < ActiveRecord::Base

	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	has_secure_password

	validates :email, presence: {message:'Email de sesiones es requerido'}, length: { maximum: 255 },
		format: {with: VALID_EMAIL_REGEX, message:'Email invalido'},
		uniqueness: {case_sensitive: false}
	validates :password, presence: {message:'Debes asignar un password'}, length: { minimum: 6 }, confirmation: true, allow_nil: true
	validates :document, presence: {message:'El documento es requerido'}
	validates :name, presence: {message:'El nombre es requerido'}
	validates :plan_id, presence: {message:'Debes asignar tipo de plan'}
	validates :lessons, presence: {message:'Numero de sesiones es requerido'}

	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/img/anon_user.png"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

	has_many :schedules, dependent: :destroy
	has_many :events
	has_many :points
	has_many :assessments
	belongs_to	 :plan
	def User.digest(string)
	    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
	                                                  BCrypt::Engine.cost
	    BCrypt::Password.create(string, cost: cost)
  	end
  	def User.new_token
    	SecureRandom.urlsafe_base64
  	end

end