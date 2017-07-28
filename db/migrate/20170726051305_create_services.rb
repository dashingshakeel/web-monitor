class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.references :type, foreign_key: true
      t.references :supervisor, foreign_key: true
      t.string :port
      t.integer :duration
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
