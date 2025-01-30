class ChangeOrderTableColumn < ActiveRecord::Migration[8.0]
  def change
    change_column :orders, :amount,:integer,using: 'amount::integer'
  end
end
