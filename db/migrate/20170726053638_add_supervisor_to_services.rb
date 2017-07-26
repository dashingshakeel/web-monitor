class AddSupervisorToServices < ActiveRecord::Migration[5.0]
  def change
    add_reference :services, :supervisor, index: true, foreign_key: true
  end
end
