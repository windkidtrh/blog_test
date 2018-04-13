# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  token           :string
#  admin           :boolean          default(FALSE)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    #模拟一个用户
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  #有效性验证
  test "should be valid" do
    assert @user.valid?
  end

  #名字是否存在验证
  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  #邮件是否存在验证
  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  #名字长度验证
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  #邮件长度验证
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
    
  #邮件格式验证
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|#上面四种类型分别检验
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end                     #显示当前的valid_address，详细值（inspect方法）
  end

  #邮件唯一性
  test "email addresses should be unique" do
    #使用 @user.dup 方法创建一个和 @user 的电子邮件地址一样的用户对象
    duplicate_user = @user.dup
    #邮件统一变成小写
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  #测试是否真的变成小写，与user.rb中的before_save相应
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    # reload 方法从数据库中重新加载数据
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  #密码最短长度
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
    
end
