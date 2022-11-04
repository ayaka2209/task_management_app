class Admin::UsersController < ApplicationController
  before_action :require_admin, only: [:new, :create]

  def index
    @users = User.select(:id, :user_name, :email, :admin).order(created_at: "DESC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path(@user), notice: "登録しました！"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path(@user), notice: "ユーザーを更新しました"
      else
        render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザーを削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :id, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    unless current_user.admin?
      flash[:danger] = 'あなたは管理者ではありません'
      redirect_to tasks_path
    end
  end
end
