# frozen_string_literal: true

FactoryBot.define do
  factory :guest, class: 'Guest' do
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.first_name }
    phone         { Faker::PhoneNumber.phone_number }
    email         { "#{first_name}_#{last_name}@somedomain.com" }
  end

  trait :incomplete do
    complete { false }
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.first_name }
    phone         { Faker::PhoneNumber.phone_number }
    email         { "#{first_name}_#{last_name}@somedomain.com" }
  end
end
