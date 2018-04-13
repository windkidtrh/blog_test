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

class User < ApplicationRecord
    #保存之前，先将邮件内容小写
    #因为有些数据库适配器的索引区分大小写
    #会把“Foo@ExAMPle.CoM”和“foo@example.com”视作不同的字符串
    
    before_save { self.email = email.downcase }

    #上面这个是回调方法（callback）
    #在用户对象存入数据库之前把电子邮件地址转换成全小写字母形式，

    validates :name,  presence: true, length: { maximum: 50 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }

    #在模型中调用这个方法后，会自动添加如下功能：
    #在数据库中的 password_digest 列存储安全的密码哈希值；
    #获得一对虚拟属性 password 和 password_confirmation，
    #而且创建用户对象时会执行存在性验证和匹配验证；
    #获得 authenticate 方法，如果密码正确，返回对应的用户对象，否则返回 false。
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    has_secure_token
    # validates :token, presence: true

    #dependent: :destroy 的作用是在用户被删除的时候，
    #把这个用户发布的微博也删除。
    #这么一来，如果管理员删除了用户，
    #数据库中就不会出现无主的微博了。
    has_many :blogs, dependent: :destroy

end
