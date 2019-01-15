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
    fields :team_id
  end
end
