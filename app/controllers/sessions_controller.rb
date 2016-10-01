class SessionsController < ApplicationController
  before_action :require_signed_out!, only: [:new, :create]
  before_action :require_signed_in!, only: [:destroy]

  def new
    render "/sessions/new"
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:name],
      params[:user][:password]
    )

    if @user
      sign_in(@user)
      redirect_to("/items")
    else
      flash.now[:errors] = ["Invalid username or password ㅠ_ㅠ"]
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to("/items")
  end

end
