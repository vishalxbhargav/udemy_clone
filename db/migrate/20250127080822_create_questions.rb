class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :description
      t.belongs_to :forume
      t.timestamps
    end
  end
end
