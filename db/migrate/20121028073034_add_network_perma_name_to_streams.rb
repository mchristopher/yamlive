class AddNetworkPermaNameToStreams < ActiveRecord::Migration
  def self.up
    add_column :streams, :network_permaname, :string
  end

  def self.down
    remove_column :streams, :network_permaname
  end
end
