class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) 
    if @user.save
      log_in @user  # login the user immediately after they do signup process
      flash[:success] = "Welcome to the Sample App baby!"
      redirect_to @user  # We could have used redirect_to user_url(@user) here which is the same.
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
