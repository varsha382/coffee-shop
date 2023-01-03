class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  # POST /login
  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      token = encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: {token: token, user: @user.as_json(only: [:name, :email])}, status: :ok
    end
  end
end
