require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Test User", email: "test_user@example.com", 
                     password: "foobar", password_confirmation: "foobar")
  end

  test "セットアップしたユーザーが有効なユーザーであることのテスト" do
    assert @user.valid?
  end
  
  test "空白のユーザー名は存在できないことのテスト" do
    @user.name = "  "
    assert_not @user.valid?
  end
  
  test "Eメールが空白のユーザーは存在できないことのテスト" do
    @user.email = " "
    assert_not @user.valid?
  end
  
  test "ユーザー名が30字までしか存在できないことのテスト" do
    @user.name = "a" * 31
    assert_not @user.valid?
  end
  
  test "ドメインを含めて255字までのメールアドレスのユーザーしか存在できないことのテスト" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "Eメールのフォーマットに沿っているユーザーであるため許可されることのテスト" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} は有効なユーザーであるべき"
    end
  end

  test "Eメールのフォーマットに沿っていないユーザーであるため許可されないことのテスト" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} は無効なユーザーであるべき"
    end
  end
  
  test "Emailがユニークでないユーザーは許可されないことの確認" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "ユーザーをデータベースに登録時小文字のEメールになっていることを確認" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "パスワードが空白のユーザーは登録できないことを確認" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "パスワードが5文字以下は登録できないことを確認" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "authenticated?はdigestの値がnilだった場合falseを返すテスト" do
    assert_not @user.authenticated?(:remember, '')
  end
  
end
