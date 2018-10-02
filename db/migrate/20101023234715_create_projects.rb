class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.integer :number
      t.datetime :start_projected
      t.datetime :end_projected
      t.datetime :start_actual
      t.datetime :end_actual
      t.integer :box_count
      t.integer :size

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
