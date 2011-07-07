class CreateIdentities < ActiveRecord::Migration
  def self.up
    create_table :identities do |t|
      t.string :password_digest
      t.string :name
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :identities
  end
end
