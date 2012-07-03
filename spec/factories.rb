FactoryGirl.define do
  factory :user do
    name                  "Michael Bluth"
    email                 "michael@bluth.com"
    password              "bananastand"
    password_confirmation "bananastand"
  end
end