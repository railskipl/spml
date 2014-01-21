class ReadingMailer < ActionMailer::Base
   default from: "android@bedcpl.com"

   def reading_count(email,count)
   	@count = count
    mail :to => email, :subject => "Readings counts"
   end

end
