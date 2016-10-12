class Post < ApplicationRecord
  scope :by_date, -> { order(created_at: :desc) }
  belongs_to :user
  has_many :comments


end
