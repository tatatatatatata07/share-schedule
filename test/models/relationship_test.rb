require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:test_jiro).id,
                                     followed_id: users(:test_saburo).id)
  end

  test "異なるユーザーの組み合わせは有効であることをテスト" do
    assert @relationship.valid?
  end

  test "follower_idがnilは失敗することをテスト" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "followed_idがnilは失敗することをテスト" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
