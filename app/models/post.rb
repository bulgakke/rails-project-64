class Post < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User"

  has_many :comments, class_name: "PostComment", dependent: :destroy

  validates :title, :body, presence: true
end
