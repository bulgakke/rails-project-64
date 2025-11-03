class PostComment < ApplicationRecord
  has_ancestry

  belongs_to :author, class_name: "User"
  belongs_to :post

  validates :content, presence: true, length: { maximum: 1000 }
end
