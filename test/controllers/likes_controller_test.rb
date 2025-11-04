require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @like = post_likes(:one)
    @post = @like.post

    sign_in @like.user
  end

  test "should create like" do
    post post_likes_url(@post)

    assert_redirected_to @post
  end

  test "should destroy like" do
    delete post_like_url(@post, @like)

    assert_redirected_to @post
  end
end
