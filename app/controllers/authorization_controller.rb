class AuthorizationController < ApplicationController
  skip_before_action :verify_authenticity_token

  def authenticate!
    req = Authentication::Authorize.new(request)
    unless req.validate_access('pass')
      Rails.logger.info "Started decoding the request.(via cookie/bearer)"
      # response.status = 200
      response.headers['Authorization'] = req.auth
    end
  end
end
