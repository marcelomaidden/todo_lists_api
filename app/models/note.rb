class Note < ApplicationRecord
  belongs_to :task

  validates :description, presence: true, length: { in: 10..200 }
end
