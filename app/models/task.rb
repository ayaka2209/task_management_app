class Task < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true

	scope :sort_expired, -> {order(expired_at: :DESC)}
	scope :created_at, -> {order(created_at: :DESC)}
	scope :sort_priority, -> {order(priority: :ASC)}
	scope :search_title_and_status, -> (title, status){where("title LIKE?", "%#{title}%").where(status:status)}
	scope :search_title, -> (title){where("title LIKE?", "%#{title}%")}
	scope :search_status, -> (status){where(status:status)}
  enum status: { 未着手: 0, 着手中: 1, 完了:2 }
  enum priority: { 高: 0, 中: 1, 低:2 }
  
  belongs_to :user
	has_many :labellings, dependent: :destroy
	has_many :tags, through: :labellings
end
