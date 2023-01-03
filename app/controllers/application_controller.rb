class ApplicationController < ActionController::API
  include ActionController::Helpers
  include JwtToken
  before_action :authenticate_user

  helper_method [:current_user]
  rescue_from ActionController::ParameterMissing do |e|
    render json: { errors: e.message }, status: 400
  end

  def authenticate_user
    begin
      header = request.headers['AuthorizationToken']
      raise "AuthorizationToken is missing" if header.nil?
      decode = decode(header)
      @current_user = User.find(decode["user_id"])
    rescue Exception => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
