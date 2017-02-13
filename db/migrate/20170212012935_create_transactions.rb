class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :kind
      t.float :amount
      t.string :status
      t.integer :from
      t.integer :to
      t.datetime :start_date
      t.datetime :eff_date
      t.references :account


      t.timestamps
    end
  end
end
