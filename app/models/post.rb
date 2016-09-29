class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :content, length: {maximum: 200}
end
