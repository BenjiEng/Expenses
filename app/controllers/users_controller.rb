class UsersController < ApplicationController

  def new
    @user = User.new
    render "/user/new"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to("/items")
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end

end