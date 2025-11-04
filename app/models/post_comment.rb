class PostComment < ApplicationRecord
  has_ancestry

  belongs_to :user, class_name: "User"
  belongs_to :post, counter_cache: :comments_count

  validates :content, presence: true, length: { maximum: 1000 }
end
