class AddNetworkIdToStreams < ActiveRecord::Migration
  def self.up
    add_column :streams, :network_id, :string
  end

  def self.down
    remove_column :streams, :network_id
  end
end
