class PlayerSerializer < Blueprinter::Base
  identifier :id do |object|
    object.public_id
  end

  fields :first_name,
    :last_name,
    :position

  view :expanded do
    association :team, blueprint: TeamSerializer
  end

  view :slim do
    field :team_id do |object|
      object.team.public_id
    end
  end
end
