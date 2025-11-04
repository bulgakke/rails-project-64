# frozen_string_literal: true

class AddCommentsCountToPosts < ActiveRecord::Migration[8.0]
  def up
    add_column :posts, :comments_count, :integer, null: false, default: 0

    Post.find_each do |post|
      Post.reset_counters(post.id, :comments)
    end
  end

  def down
    remove_column :posts, :comments_count, :integer, null: false, default: 0
  end
end
