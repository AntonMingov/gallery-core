class AddTitleEnToCategoryItems < ActiveRecord::Migration[7.1]
  def change
    add_column :category_items, :title_en, :string
  end
end
