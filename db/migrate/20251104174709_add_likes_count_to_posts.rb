# frozen_string_literal: true

class AddLikesCountToPosts < ActiveRecord::Migration[8.0]
  def up
    add_column :posts, :likes_count, :integer, null: false, default: 0

    Post.find_each do |post|
      Post.reset_counters(post.id, :likes)
    end
  end

  def down
    remove_column :posts, :likes_count, :integer, null: false, default: 0
  end
end
