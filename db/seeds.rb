%w[Music IT Movies News].each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

user = User.find_or_create_by!(email: "test@example.com", username: "test") do |user|
  user.password = "password"
end

month_ago = 1.month.ago
year_ago = 1.year.ago

Post.find_or_create_by!(title: "New post", body: "Sample post", category_id: Category.first.id, author_id: user.id)

Post.find_or_create_by!(title: "Old post", body: "Sample post 2", created_at: month_ago, updated_at: month_ago, category_id: Category.second.id, author_id: user.id)

Post.find_or_create_by!(title: "Very old post", body: "Sample post 3", created_at: year_ago, updated_at: year_ago, category_id: Category.last.id, author_id: user.id)

puts "Seeds created"
