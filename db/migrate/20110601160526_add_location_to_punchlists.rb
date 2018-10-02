class AddLocationToPunchlists < ActiveRecord::Migration
  def self.up
    add_column :punchlists, :location, :string
  end

  def self.down
    remove_column :punchlists, :location
  end
end
