require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "has author and category" do
    post = posts(:one)
    assert_equal users(:eugene), post.creator
    assert_equal categories(:one), post.category
  end
end
