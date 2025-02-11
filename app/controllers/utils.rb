module Utils

  class AccessErr < StandardError
    attr_reader :code

    def initialize(message, code)
      super(message)  # Pass the message to StandardError
      @code = code
    end
  end

  def login_params
    params.permit(:email, :password)
  end


  def session
    request.session
  end

  # def create_session(user)
  #   puts "===inside the methodd==="
  #   csrf_token = SecureRandom.hex(10)
  #   session.merge!(
  #     "uid": user.uid,
  #     "expire_time": Time.now.to_i + 24.hours,
  #     "csrf_token": csrf_token
  #   )
  #   puts "=====session==#{session.inspect}"
  #
  #   csrf_token
  # end

  def create_session(user)
    csrf_token = SecureRandom.hex(10)
    session.merge!(
      "uid": user.uid,
      "expire_time": Time.now.to_i + 24.hours.to_i,
      "csrf_token": csrf_token
    )
    csrf_token
  end

  def error!(text, code)
    Rails.logger.debug "Error raised with code #{code} and error message #{text.to_json}"
    render json: { error: text}, status: code
  end
end