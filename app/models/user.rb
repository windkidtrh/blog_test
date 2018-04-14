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
    has_many :blogs,         dependent: :destroy

    has_many :relationships, dependent: :destroy

    #让用户与微博建立主动关系
    has_many :active_relationships, class_name:  "Relationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy
# （虚拟）Table name: active_relationships （类名是Relationship）
#
#  follower_id :integer   foreign_key
#  followed_id :integer
#
    #在 relationships 表中获取一个由 followed_id 组成的集合
    #Rails 允许定制默认生成的关联方法：
    #使用 source 参数指定 following 数组由 followed_id 组成
    has_many :following, through: :active_relationships, 
                         source:  :followed

    #被动关系同样有一个虚拟table
    has_many :passive_relationships, class_name: "Relationship",
                                     foreign_key: "followed_id",
                                     dependent: :destroy
    has_many :followers, through: :passive_relationships, 
                         source:  :follower

    # # 关注另一个用户
    # def follow(other_user)
    #     following << other_user
    # end

    # # 取消关注另一个用户
    # def unfollow(other_user)
    #     following.delete(other_user)
    # end

    # # 如果当前用户关注了指定的用户，返回 true
    # def following?(other_user)
    #     following.include?(other_user)
    # end
end
