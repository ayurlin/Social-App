class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }, on: :create
  validates :password, presence: true, length: { minimum: 4 }, on: :logged_in?
  validates :last_name, presence: true
  has_many :posts
  has_many :comments
  has_many :user_friendships
  has_many :friends, 
              -> { where(user_friendships: { state: "accepted"}) }, through: :user_friendships
  has_many :pending_user_friendships, 
              -> { where  state: "pending"  }, class_name: 'UserFriendship', foreign_key: :user_id
  has_many :pending_friends, through: :pending_user_friendships, source: :friend

  enum gender: [ :male, :female ]
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def full_name
    "#{name} #{last_name}"
  end

  def self.search(search)
    where("name LIKE ? OR last_name LIKE ?", "%#{search}%", "%#{search}%") 
  end
      
  
end
