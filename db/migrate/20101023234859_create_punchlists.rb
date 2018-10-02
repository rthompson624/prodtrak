class CreatePunchlists < ActiveRecord::Migration
  def self.up
    create_table :punchlists do |t|
      t.integer :box_id
      t.integer :department_id
      t.string :material
      t.text :description
      t.datetime :completed

      t.timestamps
    end
  end

  def self.down
    drop_table :punchlists
  end
end
