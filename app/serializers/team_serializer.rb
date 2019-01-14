class TeamSerializer < Blueprinter::Base
  identifier :id

  fields :conference,
    :division,
    :city,
    :abbreviation,
    :name,
    :full_name
end
