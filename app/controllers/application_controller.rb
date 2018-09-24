class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler
    #before_action :authenticate

    def authenticate
        @jwt = JwtDecode.decode(request.headers["authorization"])
        if !@jwt
          json_response({}, 401)
        end
    end

    def get_jwt_token
        @jwt = JwtDecode.decode(request.headers["authorization"])
    end
end
