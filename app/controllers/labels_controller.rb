class LabelsController < ApplicationController

  def create
    label = current_user.labels.create(task_id: params[:task_id])
    redirect_to tasks_path, notice: "#{label.task.user.user_name"}さんのタスクをラベリングしました"
  end

  def destroy
    label = current_user.labels.find_by(id: params[:id]).destroy
    redirect_to tasks_path, notice: "#{label.task.user.user_name"}さんのタスクのラベルを解除しました"
  end
end
