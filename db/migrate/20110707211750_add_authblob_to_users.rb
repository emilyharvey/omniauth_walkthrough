class AddAuthblobToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :authblob, :binary
  end

  def self.down
    remove_column :users, :authblob
  end
end
