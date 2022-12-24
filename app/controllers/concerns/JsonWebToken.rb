require "jwt"

module JsonWebToken
    extend ActiveSupport::Concern

    SECRET_KEY = "1N1 R4H4514 94N"

    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i

        JWT.encode payload, SECRET_KEY
    end

    def self.decode(token)
        decoded = JWT.decode token, SECRET_KEY

        HashWithIndifferentAccess.new decoded[0]
    end

    def self.testing
        "masuk testing jwt"
    end
    
end