class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :destroy_if_only_one_admin, only: [:destroy]
  before_action :update_if_only_one_admin, only: [:update]

  def index
    @users = User.select(:id, :user_name, :email, :admin).order(created_at: "DESC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_params)
    if @user.save
      redirect_to admin_users_path, notice: "登録しました！"
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
      redirect_to admin_users_path, notice: "ユーザーを更新しました"
      else
        render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.tasks.destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました"
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
  def destroy_if_only_one_admin
    if User.where(admin: 'true').count == 1 && @user.admin == true
      redirect_to admin_users_path
    end
  end

  def update_if_only_one_admin
    if User.where(admin: 'true').count == 1 && @user.admin == true
      redirect_to admin_users_path
    end
  end
end
