# frozen_string_literal: true

# class UserMailer
class UserMailer < ApplicationMailer
  default from: 'patidar.wk@gmail.com'
  def welcome_email(user)
    # debugger
    @user = user
    @url  = 'http://127.0.0.1:3000/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Restaurants Website', body: '')
  end

  def owner_request(_user)
    @user = User.find_by(role: 'admin')
    @url =
      mail(to: @user.email, subject: 'User have applied for owner', body: '')
  end
end
