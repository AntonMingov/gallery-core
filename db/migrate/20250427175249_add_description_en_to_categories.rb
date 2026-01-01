class AddDescriptionEnToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :description_en, :text
  end
end
