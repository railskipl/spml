class ReadingMailer < ActionMailer::Base
   default from: "rubyrails9@gmail.com"

   def reading_count(email,count)
   	@count = count
    mail :to => email, :subject => "Readings counts"
   end

end
