class AddStatusToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :status, :string
    add_column :games, :period, :integer
    add_column :games, :time, :string

    ActiveRecord::Base.connection.execute <<~SQL
      UPDATE games
      SET status = 'Final',
      period = 4,
      time = ' '
    SQL
  end
end
