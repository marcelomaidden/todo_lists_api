class Task < ApplicationRecord
  STATUS = { uncompleted: false, completed: true }
  enum status: STATUS
  validates :title, presence: true, length: { in: 6..50 }
  scope :from_user, ->(user_id) { where(user_id: user_id) }
end
