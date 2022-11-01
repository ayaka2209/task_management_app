class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました!"
    else
      render :new
    end
  end

  def index
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      if title.present? && status.present?
        @tasks = Task.search_title_and_status(title, status)
      elsif title.present?
        @tasks = Task.search_title(title)
      elsif status.present?
        @tasks = Task.search_status(status)
      end
    elsif
      @tasks = Task.all.sort_expired
    else
      @tasks = Task.all.created_at
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
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
    params.require(:task).permit(:title, :content, :created_at, :expired_at, :status)
  end
end
