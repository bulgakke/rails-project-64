# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, inverse_of: :creator, dependent: :destroy
  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy

  validates :username,
            presence: true,
            length: { minimum: 4, maximum: 20 },
            format: { with: /\A[a-zA-Z0-9_]+\z/ }

  def username
    read_attribute(:username).presence || email.split('@').first
  end
end
