class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Our Website') do |format|
      format.text { render plain: 'Welcome to our website!' }
    end
  end
end
