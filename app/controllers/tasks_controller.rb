class TasksController < ApplicationController
  skip_before_action :forbid_login_user, only:[:index, :new, :create, :update, :show, :edit, :destroy]
  skip_before_action :prohibit_access_to_other_users, only:[:index, :new, :create, :update, :show, :edit, :destroy]
  skip_before_action :prohibit_access_except_admin, only:[:index, :new, :create, :update, :show, :edit, :destroy]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました!"
    else
      render :new
    end
  end

  def index
    # @tasks = current_user.tasks
    @tasks = current_user.tasks.created_at.page(params[:page])
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      if title.present? && status.present?
        @tasks = Task.search_title_and_status(title, status).page(params[:page])
      elsif title.present?
        @tasks = Task.search_title(title).page(params[:page])
      elsif status.present?
        @tasks = Task.search_status(status).page(params[:page])
      end
      elsif params[:sort_priority]
      @tasks = Task.all.sort_priority.page(params[:page])
      elsif params[:sort_expired]
      @tasks = Task.all.sort_expired.page(params[:page])
    end
  end

  def show
    @task = current_user.tasks.find(params[:id])
    @label = current_user.labels.find_by(task_id: @task.id)
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :created_at, :expired_at, :status, :priority, :user_id)
  end
end
