class AddAuthdomToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :authdom, :binary
  end

  def self.down
    remove_column :users, :authdom
  end
end
