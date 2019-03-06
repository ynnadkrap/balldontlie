class PlayerSerializer < Blueprinter::Base
  identifier :id do |object|
    object.public_id
  end

  fields :first_name,
         :last_name,
         :position,
         :height_feet,
         :height_inches,
         :weight_pounds

  view :expanded do
    association :team, blueprint: TeamSerializer
  end

  view :slim do
    field :team_id do |object|
      object.team.public_id
    end
  end
end
