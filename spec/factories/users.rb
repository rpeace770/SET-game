FactoryGirl.define do
  factory :user do
    username  "thisisusername"
    email     "email@example.com"
    password  "123123"

    factory :invalid_user do
      password  "123"
    end
  end


end
