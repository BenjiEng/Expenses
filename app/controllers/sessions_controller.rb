class SessionsController < ApplicationController
  before_action :require_signed_out!, only: [:create]
  before_action :require_signed_in!, only: [:destroy]

  def new
    render "/session/new"
  end

  def create
    @user = User.find_by_credentials(params[:user][:name],params[:user][:password])

    if @user
      sign_in(@user)
      redirect_to("/items")
    else
      flash.now[:errors] = ["Invalid username or password ㅠ_ㅠ"]
      render "session/new"
    end
  end

  def destroy
    sign_out
    redirect_to "/session/new"
  end

end
