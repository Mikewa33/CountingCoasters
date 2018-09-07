require 'jwt'
module JwtDecode
  def self.decode(token)
    #HMAC_SECRET = Rails.application.secrets.secret_key_base
    # get payload; first index in decoded Array
    begin
      jwt = JWT.decode(token, 'Superpassword123local')[0]
      HashWithIndifferentAccess.new jwt
      #TO-DO LOOK FOR BETTER WAY TO HANDLE THIS
      if ((Time.now.to_f * 1000.0).to_i > jwt["exp"])
        return nil
      else
        return jwt
      end
    # rescue from expiry exception
    rescue
      return nil
    end
  end
end
