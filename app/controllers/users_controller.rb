class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  skip_before_action :prohibit_login_user, only:[:show]
  skip_before_action :require_user, only:[:new, :create]
  skip_before_action :require_admin, only:[:new, :create, :show]

  def new
    @user = User.new
  end

  def create
    # byebug
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :admin)
  end

  # def require_user
  #   if current_user.id != params[:id].to_i
  #     flash[:notice] = 'あなたはログインしたユーザーではありません'
  #     redirect_to tasks_path
  #   end
  # end
end
