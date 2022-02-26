class Note < ApplicationRecord
  include ActiveModel::Serializers::JSON
  belongs_to :task

  validates :description, presence: true, length: { in: 10..200 }

  def attributes
    { 'id': nil, 'description': nil }
  end
end
