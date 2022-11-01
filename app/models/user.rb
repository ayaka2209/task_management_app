class User < ApplicationRecord
  has_many :tasks
  before_validation { email.downcase! }
end
