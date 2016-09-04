class Gymail < ApplicationMailer
	 default from: "elitefitnesscenterco@gmail.com"
   def register_email(user)
    @user = user
    mail(to: 'sandra-munoz2014@hotmail.com', subject: 'Sample Email')
   end
end
