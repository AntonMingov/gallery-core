class AddStaticLabels < ActiveRecord::Migration[7.1]
  def change
    create_table :static_labels do |t|
      t.string :scope, limit: 30, null: false, default: 'common'
      t.text :key
      t.text :value
      t.boolean :archived
      t.timestamps null: false
    end
  end
end
