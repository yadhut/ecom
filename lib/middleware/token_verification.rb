class TokenVerification
  def initialize(app)
    @app = app
  end

  def call(env)
    request = ActionDispatch::Request.new(env)

    req = Authentication::Authorize.new(request)

    req.auth unless req.validate_access('pass')

    @app.call(env)
  end
end