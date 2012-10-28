class AddNetworkIdsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :network_ids, :text
  end

  def self.down
    remove_column :users, :network_ids
  end
end
