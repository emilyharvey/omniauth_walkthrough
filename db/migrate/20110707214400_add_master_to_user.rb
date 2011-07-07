class AddMasterToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :master, :integer
  end

  def self.down
    remove_column :users, :master
  end
end
