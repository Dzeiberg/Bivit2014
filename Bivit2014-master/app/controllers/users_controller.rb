class UsersController < ApplicationController
  def new
  	@user = User.new
  end
  def show
  	@user = User.find(params[:id])
  end
  def index
    if !signed_in?
      @users = User.none
      redirect_to '/signin'
    else
  	@users = User.all
  end
end

   def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      sign_in @user
    	flash[:success] = "Welcome to Bivit!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end