# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'patidar.wk@gmail.com'
  def welcome_email(user)
    # debugger
    @user = user
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to Restaurants Website', body: '')
  end
  def owner_request(user)
    @user = User.find_by(role: 'admin')
    mail(to: @user.email, subject: 'User have applied for owner')
  end
end
