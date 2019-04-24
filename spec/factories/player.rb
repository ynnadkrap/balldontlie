# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    id
    public_id { generate(:id) }
    first_name { 'Derrick' }
    last_name { 'Rose' }
    position { 'PG' }
    height_feet { 6 }
    height_inches { 3 }
    weight_pounds { 200 }
    team
  end
end
