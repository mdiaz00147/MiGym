class Gymail < ApplicationMailer
	default from: "elitefitnesscenterco@gmail.com"
   def register_email(user)
    @user = user
    mail(to: 'sectorstream@hotmail.com', subject: "Bienvenido a Elite Fintess #{user.name.upcase}")
   end
   def reminder(user)
    @user = user
    mail(to: 'sectorstream@hotmail.com', subject: "RECUERDA a Elite Fintess #{user.name.upcase}")
   end
end