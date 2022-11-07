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

    respond_to do |format|
      if @task.save
      format.html { redirect_to tasks_path(@task), notice: "Task was successfully created." }
      format.json { render :show, status: :created, location: @task }
      else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    # @tasks = current_user.tasks
    @tasks = current_user.tasks.created_at.page(params[:page])
    @tasks = @tasks.joins(:tags).where(tags: { id: params[:tag_ids] }) if params[:tag_ids].present?
    if params[:task].present?
      title = params[:task][:title]
      status = params[:task][:status]
      tag = params[:task][:tag_id]
      if title.present? && status.present?
        @tasks = Task.search_title_and_status(title, status).page(params[:page])
      elsif title.present?
        @tasks = Task.search_title(title).page(params[:page])
      elsif status.present?
        @tasks = Task.search_status(status).page(params[:page])
      elsif tag.present?
        task_id = Labelling.where(tag_id: tag).pluck(:task_id)
        @tasks = Task.page(params[:page]).where(id: task_id)
      end
      elsif params[:sort_priority]
      @tasks = Task.all.sort_priority.page(params[:page])
      elsif params[:sort_expired]
      @tasks = Task.all.sort_expired.page(params[:page])
    end
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    # @task = current_user.tasks.find(params[:id])
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
    # if @task.update(task_params)
    #   redirect_to tasks_path, notice: "タスクを編集しました！"
    # else
    #   render :edit
    # end
  

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :created_at, :expired_at, :status, :priority, { tag_ids: [] })
  end

  # def tag_params
  #   params.require(:task).permit(:title, { tag_ids: [] })
  # end
end
