class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :status
      t.float :balance
      t.references :user
      t.timestamps
    end
  end
end
