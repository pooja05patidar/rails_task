# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'patidar.wk@gmail.com'
  def welcome_email(user)
    # debugger
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to Restaurants Website', body: '')
  end
end
