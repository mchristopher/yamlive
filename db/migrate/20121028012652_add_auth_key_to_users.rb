class AddAuthKeyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :auth_key, :text
  end

  def self.down
    remove_column :users, :auth_key
  end
end
