class CreateBoxes < ActiveRecord::Migration
  def self.up
    create_table :boxes do |t|
      t.integer :project_id
      t.string :serial
      t.datetime :start_projected
      t.datetime :end_projected
      t.datetime :start_actual
      t.datetime :plant_discharge
      t.datetime :end_actual
      t.integer :size

      t.timestamps
    end
  end

  def self.down
    drop_table :boxes
  end
end
