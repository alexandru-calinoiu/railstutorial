class User < ActiveRecord::Base
  has_many :microposts

  def formatted_email
    "#{@name} <#{@email}>"
  end
end
