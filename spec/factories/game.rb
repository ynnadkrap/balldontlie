FactoryBot.define do
  factory :game do
    id
    public_id { generate(:id) }
    date { Date.new(2019, 1, 1) }
    status { 'Final' }
    period { 4 }
    time { ' ' }
    association :home_team, factory: :team_east
    association :visitor_team, factory: :team_west
    season { 2018 }
    postseason { false }
  end
end
