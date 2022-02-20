class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  # GET /users or /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  # GET /users/1 or /users/1.json
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the blog #{@user.username}, you have successfully signed up!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
      if @user.update(user_params)
        flash[:notice] = "Your account information was successfully updated!"
        redirect_to @user
      else
        render 'new'
      end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user
        flash[:alert] = "You can only edit your own account"
        redirect_to @user
      end
    end
end
