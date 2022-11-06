class SessionsController < ApplicationController
  skip_before_action :login_required, only:[:new, :create, :destroy]
  skip_before_action :forbid_login_user, only:[:new, :create, :destroy]
  skip_before_action :prohibit_access_to_other_users, only:[:new, :create, :destroy]
  skip_before_action :prohibit_access_except_admin, only:[:new, :create, :destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end