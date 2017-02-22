class CreateConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :connections do |t|
      t.string :status
      t.integer :sender
      t.integer :recipient

      t.timestamps
    end
  end
end
