class JsonWebToken

  def initialize(options)
    raise "Missing private key" unless options[:key]
    @options = options.reverse_merge({
                                       algoritm: 'RS256',
                                       expire: 3600,
                                       sub: 'session',
                                       iss: 'ecom',
                                       aud: %w[ecom]
                                     })
  end

  def encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, @options[:key], @options[:algoritm])
  end

  def decode(token)
    decoded = JWT.decode(token, @options[:key])[0]
    HashWithIndifferentAccess.new decoded
  end
end
