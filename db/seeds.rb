# frozen_string_literal: true

%w[Music IT Movies News].each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

user = User.find_or_create_by!(email: 'test@example.com', username: 'testuser') do |user|
  user.password = 'password'
end

month_ago = 1.month.ago
year_ago = 1.year.ago

post = Post.find_or_create_by!(title: 'New post', body: 'Sample post', category_id: Category.first.id, creator_id: user.id)

Post.find_or_create_by!(title: 'Old post', body: 'Sample post 2', category_id: Category.second.id, creator_id: user.id) do |post|
  post.created_at = month_ago
  post.updated_at = month_ago
end

Post.find_or_create_by!(title: 'Very old post', body: 'Sample post 3', category_id: Category.last.id, creator_id: user.id) do |post|
  post.created_at = year_ago
  post.updated_at = year_ago
end

first_comment = PostComment.find_or_create_by!(content: 'First comment', user_id: user.id, post_id: post.id)

PostComment.find_or_create_by!(content: 'Second comment', user_id: user.id, post_id: post.id) do |comment|
  comment.parent = first_comment
end

current_comment = PostComment.find_or_create_by!(content: 'Beginning of a very deep chain of comments', user_id: user.id, post_id: post.id)

33.times do |i|
  next_comment = PostComment.find_or_create_by!(content: "#{'very ' * i}deep comment", user_id: user.id, post_id: post.id) do |comment|
    comment.parent = current_comment
  end

  current_comment = next_comment
end

Rails.logger.debug 'Seeds created'
