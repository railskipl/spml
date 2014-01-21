class UserMailer < ActionMailer::Base
  default from: "android@bedcpl.com"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end

