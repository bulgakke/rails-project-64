module PostsHelper
  def updated?(post)
    post.updated_at != post.created_at
  end
end
