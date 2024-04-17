# frozen_string_literal: true

# app/services/jwt_service.rb
# class JwtServices
#   def self.encode(payload)
#     JWT.encode(payload, Rails.application.secrets.secret_key_base)
#   end

#   def self.decode(token)
#     decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
#     HashWithIndifferentAccess.new(decoded_token)
#   end
# end
