FactoryBot.define do
  factory :team do
    conference { 'East' }
    division { 'Central' }
    city { 'Chicago' }
    abbreviation { 'CHI' }
    name { 'Bulls' }
    full_name { 'Chicago Bulls' }
  end

  factory :team_east, class: Team do
    conference { 'East' }
    division { 'Central' }
    city { 'Chicago' }
    abbreviation { 'CHI' }
    name { 'Bulls' }
    full_name { 'Chicago Bulls' }
  end

  factory :team_west, class: Team do
    conference { 'West' }
    division { 'Pacific' }
    city { 'Los Angeles' }
    abbreviation { 'LAL' }
    name { 'Lakers' }
    full_name { 'LA Lakers' }
  end
end
