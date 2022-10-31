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
        search_title_and_status = params[:search_title_and_status]
      elsif title.present?
        search_title = params[:task][:title]
        elsif status.present?
          search_status = params[:task][:status]
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
    params.require(:task).permit(:title, :content, :expired_at, :status)
  end
end
