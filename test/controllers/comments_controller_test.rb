# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = post_comments(:one)
    @post = @comment.post

    sign_in users(:eugene)
  end

  test 'should create comment' do
    assert_difference('PostComment.count') do
      post post_comments_url(@post), params: { post_comment: { content: 'test', ancestry: '/', creator_id: users(:eugene).id } }
    end

    assert_redirected_to post_url(@post)
  end

  test 'should update comment' do
    patch post_comment_url(@post, @comment), params: { post_comment: { content: 'new' } }
    assert_redirected_to post_url(@post)
  end

  test 'should destroy comment' do
    assert_difference('PostComment.count', -1) do
      delete post_comment_url(@post, @comment)
    end

    assert_redirected_to post_url(@post)
  end
end
