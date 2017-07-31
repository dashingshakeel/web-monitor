class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.references :user, foreign_key: true
      t.references :supervisor, foreign_key: true
      t.references :service, foreign_key: true
      t.string :status
      t.references :type, foreign_key: true
      t.string :response_time

      t.timestamps
    end
  end
end
