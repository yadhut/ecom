class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  rescue_from ActiveRecord::RecordInvalid, with: :handler_for_rescue

  def create
    user = User.create!(user_params)
    token = codec.encode(user.as_payload)
    render json: {
      user:  user.as_payload,
      token: token,
      status: :created
    }
  end

  def user_params
    params.permit(:first_name, :last_name, :password, :email, :phone_number, :dob)
  end

  def handle_invalid_record
    render json: { error: e.record.errors.full_message }, status: :unprocessable_entity
  end

  private

  def codec
    JsonWebToken.new(key: Rails.application.config.x.keystore.private_key)
  end
end

