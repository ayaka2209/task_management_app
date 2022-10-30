class Task < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true

	scope :sort_expired, -> {order(expired_at: :DESC)}
	scope :created_at, -> {order(created_at: :DESC)}

end
