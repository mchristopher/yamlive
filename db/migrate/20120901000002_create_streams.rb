class CreateStreams < ActiveRecord::Migration
  def self.up
    create_table :streams do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false
      t.string :state
      t.text :description
      t.integer :zc_job_id
      t.string :zc_stream_name
      t.string :zc_stream_url, :limit => 512

      t.timestamps
    end
  end

  def self.down
    drop_table :streams
  end
end
