class User < ApplicationRecord
  include ActiveModel::Serializers::JSON

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def attributes
    { 'id': nil, 'email': nil }
  end
end
