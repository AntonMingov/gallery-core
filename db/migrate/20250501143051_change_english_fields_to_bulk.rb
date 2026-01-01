class ChangeEnglishFieldsToBulk < ActiveRecord::Migration[7.1]
  def change
    change_table :categories, bulk: true do |t|
      t.string :name_en unless column_exists?(:categories, :name_en)
    end

    change_table :friends, bulk: true do |t|
      t.string :name_en unless column_exists?(:friends, :name_en)
      t.text :description_en unless column_exists?(:friends, :description_en)
    end

    change_table :testimonials, bulk: true do |t|
      t.string :title_en unless column_exists?(:testimonials, :title_en)
      t.text :description_en unless column_exists?(:testimonials, :description_en)
    end
  end
end
