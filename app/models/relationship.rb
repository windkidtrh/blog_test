# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Relationship < ApplicationRecord
    #一个“关系”涉及两个用户,
    #第一行是关注者，第二行是被关注者
    #降序排列
    default_scope -> { order(created_at: :desc) }

    belongs_to :follower, class_name: "User"
    belongs_to :followed, class_name: "User"
    validates  :follower_id, presence: true
    validates  :followed_id, presence: true

end
