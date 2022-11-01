class Task < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true

	scope :sort_expired, -> {order(expired_at: :ASC)}
	scope :created_at, -> {order(created_at: :DESC)}
	scope :sort_priority, -> {order(sort_expired: :DESC)}
	scope :search_title_and_status, -> (title, status){where("title LIKE?", "%#{title}%").where(status:status)}
	scope :search_title, -> (title){where("title LIKE?", "%#{title}%")}
	scope :search_status, -> (status){where(status:status)}
  enum status: { 未着手: 0, 着手中: 1, 完了:2 }
  enum priority: { 高: 0, 中: 1, 低:2 }
	

end
