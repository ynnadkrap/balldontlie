# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    id
    public_id { generate(:id) }
    conference { 'East' }
    division { 'Central' }
    city { 'Chicago' }
    abbreviation { 'CHI' }
    name { 'Bulls' }
    full_name { 'Chicago Bulls' }
  end

  factory :team_east, class: Team do
    id
    public_id { generate(:id) }
    conference { 'East' }
    division { 'Central' }
    city { 'Chicago' }
    abbreviation { 'CHI' }
    name { 'Bulls' }
    full_name { 'Chicago Bulls' }
  end

  factory :team_west, class: Team do
    id
    public_id { generate(:id) }
    conference { 'West' }
    division { 'Pacific' }
    city { 'Los Angeles' }
    abbreviation { 'LAL' }
    name { 'Lakers' }
    full_name { 'LA Lakers' }
  end
end
