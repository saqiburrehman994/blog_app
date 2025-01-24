require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "should not save post without title" do
    user = User.create!(email: "unique_email@example.com", password: "password")
    post = Post.new(user: user) # Associate the post with the created user
    assert_not post.save
  end
end
