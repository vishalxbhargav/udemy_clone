class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.string :message
      t.boolean :is_read,default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
