FactoryGirl.define do
  factory :user do
    HPFaker               = HarryPotterFaker.new()
    name                  HPFaker.name
    sequence :email do |n|
      Faker::Internet.email(n)
    end
    password              "password"
    password_confirmation "password"
    factory :user_with_projects do
      projects {create_list(:project, 2)}
    end
  end
end
