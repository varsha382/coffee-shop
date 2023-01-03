class RegistrationController < ApplicationController
  include JwtToken
  skip_before_action :authenticate_user

  # POST /register
  def create
    @user = User.new(user_params)
    if @user.save
      token = encode({user_id: @user.id})
      time = Time.now + 24.hours.to_i
      render json: {token: token, user: @user.as_json(only: [:name, :email]), errors: [], message: "Successfully Registered user"}, status: :ok
    else
      render json: {token: nil, user: nil, errors: @user.errors.messages, message: ""}, status: :ok
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
