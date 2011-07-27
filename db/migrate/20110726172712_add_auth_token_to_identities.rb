class AddAuthTokenToIdentities < ActiveRecord::Migration
  def self.up
    add_column :identities, :auth_token, :string
  end

  def self.down
    remove_column :identities, :auth_token
  end
end
