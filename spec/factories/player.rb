FactoryBot.define do
  factory :player do
    id
    public_id { generate(:id) }
    first_name { 'Derrick' }
    last_name { 'Rose' }
    position { 'PG' }
    team
  end
end
