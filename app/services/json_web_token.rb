require 'jwt'

class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, 'secret')
  end

  def self.decode(token)
    decoded = JWT.decode(token, 'secret')[0]
    HashWithIndifferentAccess.new(decoded)
  end
end
