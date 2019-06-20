# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'foo@bar.com' }
    password { 'foobar' }
  end
end
