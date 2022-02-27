class User < ApplicationRecord
  include ActiveModel::Serializers::JSON

  has_secure_password

  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true

  has_many :tasks

  def attributes
    { 'id': nil, 'email': nil }
  end
end
