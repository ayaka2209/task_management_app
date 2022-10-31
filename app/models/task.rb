class Task < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true

	scope :sort_expired, -> {order(expired_at: :DESC)}
	scope :created_at, -> {order(created_at: :DESC)}
	scope :search_status, -> {where(status: :search_status)}
  enum status: { 未着手: 0, 着手中: 1, 完了:2 }
	# validates :status, inclusion: { in:Task.statuses }
	# def toggle_status!
	# 	if 未着手?
		
	# end

end
