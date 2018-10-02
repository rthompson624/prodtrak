class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :user
      t.string :password
      t.string :role

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
