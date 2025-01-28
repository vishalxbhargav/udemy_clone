class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.string :body
      t.belongs_to :answer
      t.timestamps
    end
  end
end
