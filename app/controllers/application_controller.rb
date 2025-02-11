class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def current_user
    header = request.headers['Authorization']
    @current_user ||= if header
                        token = header.split(' ')[1]
                        begin
                          d_token = JsonWebToken.new({ key: ENV["JWT_SECRET_KEY"] }).decode(token)[0]
                          User.find_by(uid: d_token['uid'])
                        rescue JWT::DecodeError
                          nil
                        end
                      elsif session[:uid]
                         User.find_by(uid: session[:uid])
                      end
  end

  def authorized
    unless !current_user
      render json: { message: "Please login" }, status: :unauthorized
    end
  end
end
