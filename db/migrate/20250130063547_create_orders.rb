class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.integer :status,default: 0
      t.string :amount
      t.string :transaction_id

      t.timestamps
    end
  end
end
