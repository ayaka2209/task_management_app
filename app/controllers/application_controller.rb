class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :login_required
  before_action :forbid_login_user
  before_action :prohibit_access_to_other_users
  before_action :prohibit_access_except_admin

  private

  def login_required
    redirect_to new_session_path unless current_user
  end

  def prohibit_login_user
    if logged_in?
      flash[:notice] = "ログインしています"
      redirect_to tasks_path
    end
  end

  def require_user
    if current_user.id != params[:id].to_i
      flash[:notice] = "あなたはログインしたユーザーではありません"
      redirect_to tasks_path
    end
  end

  def require_admin
    unless current_user.admin?
      flash[:notice] = "あなたは管理者ではありません"
      redirect_to tasks_path
    end
  end
end
