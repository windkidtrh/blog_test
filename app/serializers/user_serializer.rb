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

class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :password

  attribute :token do
    #:with_token只是名字而已，并不重要
    object.token if instance_options[:with_token]
  end
end
