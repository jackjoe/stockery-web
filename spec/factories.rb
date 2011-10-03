FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@domain.com"
  end

  sequence :name do |n|
    "portfolio-#{n}"
  end

  factory :portfolio do
    name
    email
  end
end
