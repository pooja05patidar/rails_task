# frozen_string_literal: true

# class sessions controller
class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user_info = request.env['omniauth.auth']
    rails user_info
  end
end
