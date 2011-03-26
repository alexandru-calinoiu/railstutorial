# == Schema Information
# Schema version: 20110320193313
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many :microposts

  attr_accessible :name, :email

  def formatted_email
    "#{name} | <#{email}>"
  end
end
