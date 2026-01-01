class CreateCategoryItems < ActiveRecord::Migration[7.1]
  def change
    create_table :category_items do |t|
      t.string :title

      t.belongs_to :category, index: true, foreign_key: true
      t.timestamps
    end
  end
end
