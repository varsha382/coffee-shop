require 'jwt'

module JwtToken
  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def decode(token)
    decoded_token = JWT.decode(token, SECRET_KEY)[0]
  end
  
  def encode(payload, exp: 7.days.from_now)
    payload[:exp] = exp.to_i
    token = JWT.encode(payload, SECRET_KEY)
  end
end