module Authentication
  class Authorize

    class AuthError < StandardError
      attr_reader :code

      # init an error with status and text to return in api response
      def initialize(code)
        super
        @code = code
      end
    end
    def initialize(req)
      @req = req
      @path = req.path
      @access = load_access['rules']
    end

    def auth
      auth_type = 'cookie'
      auth_type = 'bearer_token' if authorization_header?
      puts "=====auth typee===#{auth_type}="
      auth_owner = method("#{auth_type}_owner").call
      @req.env['current_user_payload'] = auth_owner.uid
      'Bearer ' + codec.encode(auth_owner.as_payload)
    end

    def cookie_owner
      Rails.logger.info("Authorization through Cookies")
      error!({ errors: ['auth.invalid_session'] }, 401) unless session[:uid]

      user = User.find_by(uid: session[:uid])
      error!({ errors: ['auth.invalid_session'] }, 401) unless user
      user
    end

    def bearer_token_owner
      Rails.logger.info("Authorization through Bearer token")

      header = @req.headers['Authorization']
      if header
        token = header.split(' ')[1]
        begin
          d_token = JsonWebToken.new({ key: key_store.public_key })
          puts "===decoded token==#{d_token}===#{d_token.decode(token)}"
          d_token = d_token.decode(token)[0]
          User.find_by(uid: d_token['uid'])
        rescue JWT::DecodeError => e
          Rails.logger.error e.inspect
          nil
        end
      end
    end


    def session
      @req.session
    end

    def authorization_header?
      @req.headers['Authorization'].present?
    end

    def codec
      JsonWebToken.new(key: key_store.private_key)
    end

    def validate_access(type)
      @access[type].each do |path|
        return true if @path.start_with?(path)
      end
      false
    end

    def key_store
      Rails.application.config.x.keystore
    end

    def load_access
      YAML.safe_load(ERB.new(File.read(Rails.root.join('config', 'access_rules.yml'))).result)
    end

    def error!(text, code)
      Rails.logger.debug "Error raised with code #{code} and error message #{text.to_json}"
      raise AuthError.new(code),  text.to_json
    end
  end
end