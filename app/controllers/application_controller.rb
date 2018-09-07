class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler
    before_action :authenticate

    def authenticate
        @jwt =  JwtDecode.decode(request.headers["authorization"])
        if !@jwt
          json_response({error: "Error"}, 401)
        end
    end
end
