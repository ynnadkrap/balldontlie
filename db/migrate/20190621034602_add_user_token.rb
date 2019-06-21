# frozen_string_literal: true

class AddUserToken < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :token, :string, null: false
    add_index :users, :token, unique: true
  end
end
