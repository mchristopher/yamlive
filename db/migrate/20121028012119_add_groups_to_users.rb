class AddGroupsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :groups, :text
    add_column :users, :networks, :text
    add_column :streams, :group_id, :string
    remove_column :users, :network_ids
  end

  def self.down
    remove_column :users, :groups
    remove_column :users, :networks
    remove_column :streams, :group_id
    add_column :users, :network_ids, :text
  end
end
