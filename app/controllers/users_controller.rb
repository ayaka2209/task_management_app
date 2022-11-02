class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    # byebug
    @user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end
  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end
end
