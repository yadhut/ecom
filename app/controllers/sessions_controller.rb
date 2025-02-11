class SessionsController < ApplicationController
  # protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token


  include Utils
  def login
    user = User.find_by(email: login_params[:email])
    @current_user = user
    error!(['identity.user.not_found'], 401 ) unless user

    error!(['identity.user.invalid.password'], 400) unless user.authenticate(login_params[:password])

    session[:uid] = user.uid
    csrf_token = create_session(user)
    render json: user.as_payload.merge!(csrf_token: csrf_token), status: :ok
  end

  def logout
    user = User.find_by(uid: request.session["uid"])
    unless user
      error!(['identity.user.invalid.session'], 401)
      return
    end

    session.destroy
    @current_user = nil

    render json: {message: 'successfully logged out'}
  rescue => e
    Rails.logger.error e
    error!(['identity.user.invalid.session'], 401)
  end
end
