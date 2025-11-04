class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, inverse_of: :creator
  has_many :comments, class_name: "PostComment"
  has_many :likes, class_name: "PostLike"

  def username
    read_attribute(:username).presence || email.split("@").first
  end
end
