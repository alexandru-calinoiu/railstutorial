require "factory_girl_rails"

Factory.define :user do |user|
  user.name                   "Calin"
  user.email                  "calin@gmail.com"
  user.password               "password"
  user.password_confirmation  "password"
end