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

class BlogSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at
  #下面这句会把user_serializer中的
  #返回内容也显示出来
  # belongs_to :user
end
