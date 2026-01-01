class AddTestimonials < ActiveRecord::Migration[7.1]
  def change
    create_table :testimonials do |t|
      t.string :title, default: ' ', null: false
      t.text :description, default: ' ', null: false
      t.boolean :is_authorised, default: false

      t.timestamps null: false
    end
  end
end
