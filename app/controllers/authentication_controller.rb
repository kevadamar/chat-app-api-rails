class AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login


    # POST /auth/login
    def login
        @user = User.find_by_username(params[:username]).select([:username,:email,:id])
        if @user&.authenticate(params[:password])
            token = JsonWebToken.encode(user: JSON.parse(@user.to_json(:except => [:password_digest])))
            time = Time.now + 24.hours.to_i
            render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                            username: @user.username }, status: :ok
        else
            render json: { error: 'unauthorized gan' }, status: :unauthorized
        end
    end

    private

    def login_params
        params.permit(:username, :password)
    end
end
