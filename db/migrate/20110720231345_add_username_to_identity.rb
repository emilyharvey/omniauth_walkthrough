class AddUsernameToIdentity < ActiveRecord::Migration
  def self.up
    add_column :identities, :username, :string
  end

  def self.down
    remove_column :identities, :username
  end
end
