class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.references :type, foreign_key: true
      t.references :supervisor, foreign_key: true
      t.string :port
      t.integer :duration
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
