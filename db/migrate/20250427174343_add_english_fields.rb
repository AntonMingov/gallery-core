class AddEnglishFields < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :name_en, :string
    add_column :friends, :name_en, :string
    add_column :friends, :description_en, :text
    add_column :testimonials, :title_en, :string
    add_column :testimonials, :description_en, :text
  end
end
