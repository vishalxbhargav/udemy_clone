class AddCompletedChapterStatus < ActiveRecord::Migration[8.0]
  def change
    add_column :chapters, :completed, :boolean, default: false
  end
end
