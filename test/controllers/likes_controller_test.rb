# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @like = post_likes(:one)
    @post = @like.post
    @post_without_like = posts(:two)

    sign_in @like.user
  end

  test 'should create like' do
    post post_likes_url(@post_without_like)

    assert { @post_without_like.reload.likes.one? }

    assert_redirected_to @post_without_like
  end

  test 'should not create like by same user' do
    post post_likes_url(@post)

    assert { @post.reload.likes.one? }

    assert_redirected_to @post
  end

  test 'should destroy like' do
    delete post_like_url(@post, @like)

    assert { @post.reload.likes.none? }

    assert_redirected_to @post
  end

  test 'should not destroy by another user' do
    sign_in users(:two)

    delete post_like_url(@post, @like)

    assert { @like.reload.destroyed? == false }

    assert_redirected_to @post
  end
end
