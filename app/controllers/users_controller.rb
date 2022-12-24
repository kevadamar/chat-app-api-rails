class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    # request.query_parameters[:test]
    # check query params
    queryParams = request.query_parameters
    relation = { :include => { :contacts => {
      :include => { 
        :my_contact => { 
          :except => [:password_digest, :created_at,:updated_at] 
          }
        }, except: [:created_at, :updated_at]
      } }, except: [:password_digest, :updated_at] }
    @users = User.all

    if queryParams.present?
      if queryParams[:isLogged].present?
        @users = User.where(['id != ?', @current_user[:id]])
      end
      
      render json: {data: @users.as_json(relation), status: 200}
    end
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.as_json(except: [:password_digest]), status: :created, location: @user
    else
      render json: {error: @user.errors, status: 422}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # find user by username
    def find_user
      @user = User.find_by_username!(params[:_username])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:email, :username, :password)
    end
end
