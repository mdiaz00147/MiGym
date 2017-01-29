class Assessment < ActiveRecord::Base
	belongs_to :user
	validates :body_water, presence: {message:'Porcentaje de agua requerido'}, length: { maximum: 10 }, numericality: true
	validates :bone, presence: {message:'Porcentaje mas osea es requerido'}, length: { maximum: 10 }, numericality: true
	validates :bmi, presence: {message:'Porcentaje de BMI es requerido'}, length: { maximum: 10 }, numericality: true
	validates :visceral_fat, presence: {message:'Porcentaje grasa visceral es requerido'}, length: { maximum: 10 }, numericality: true
	validates :bmr, presence: {message:'Porcentaje de BMR es requerido'}, length: { maximum: 10 }, numericality: true
	validates :muscle_mass, presence: {message:'Porcentaje masa muscular es requerido'}, length: { maximum: 10 }, numericality: true
	validates :weight, presence: {message:'Peso es requerido'}, length: { maximum: 10 }, numericality: true
	validates :user_id, presence: {message:'Debes asignar valoracion a un usuario'}, length: { maximum: 10 }, numericality: true
end
