# == Schema Information
#
# Table name: blogs
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Blog < ApplicationRecord
  #降序显示内容,->接受一个代码块,返回一个 Proc，
  #然后在这个Proc 上调用 call 方法执行其中的代码
  default_scope -> { order(created_at: :desc) }

  validates  :user_id, presence: true 
  validates  :content, presence: true, length: { maximum: 140 }

  #之所以可以这么写，是因为 microposts 表中有识别用户的 user_id
  #这里跟blog控制器的destroy代码有关联
  belongs_to :user

end
