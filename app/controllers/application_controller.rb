class ApplicationController < ActionController::API
    include JsonWebToken

    def not_found
        render json: {error: "Not Found", status: 404}
    end

    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode header
            @current_user = User.select([:id]).find(@decoded[:user][:id])
        rescue ActiveRecord::RecordNotFound => e
            render json: {error: e.message, status: :unauthorized}, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: {error: e.message, status: :unauthorized}, status: :unauthorized
        end
    end
end
