class Gymail < ApplicationMailer
	default from: "elitefitnesscenterco@gmail.com"
   def register_email(user)
    @user = user
    mail(to: user.email, subject: "Bienvenido a Elite Fintess #{user.name.upcase}")
   end
   def reminder(user)
    @user = user
    mail(to: user.email, subject: "Hace rato no sabemos de ti #{user.name.upcase}")
   end
end