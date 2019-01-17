class AddCustomIds < ActiveRecord::Migration[5.1]
  def change
    # add columns
    ActiveRecord::Base.connection.execute <<~SQL
    alter table games add column public_id serial
    SQL

    ActiveRecord::Base.connection.execute <<~SQL
    alter table player_stats add column public_id serial
    SQL

    ActiveRecord::Base.connection.execute <<~SQL
    alter table players add column public_id serial
    SQL

    ActiveRecord::Base.connection.execute <<~SQL
    alter table teams add column public_id serial
    SQL

    # add index
    ActiveRecord::Base.connection.execute <<~SQL
    create index idx_games_public_id on games (public_id)
    SQL

    ActiveRecord::Base.connection.execute <<~SQL
    create index idx_player_stats_public_id on player_stats (public_id)
    SQL

    ActiveRecord::Base.connection.execute <<~SQL
    create index idx_players_id on players (public_id)
    SQL

    ActiveRecord::Base.connection.execute <<~SQL
    create index idx_teams_public_id on teams (public_id)
    SQL
  end
end
