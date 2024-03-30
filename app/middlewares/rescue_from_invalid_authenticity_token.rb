# app/middlewares/rescue_from_invalid_authenticity_token.rb
class RescueFromInvalidAuthenticityToken
  def call(env)
    yield
  rescue ActionController::InvalidAuthenticityToken
    [302, { 'Location' => '/sessions/new', 'Content-Type' => 'text/html' }, ['Invalid Authenticity Token']]
  end
end
