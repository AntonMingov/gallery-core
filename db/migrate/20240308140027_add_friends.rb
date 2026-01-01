class AddFriends < ActiveRecord::Migration[7.1]
  def change
    create_table :friends do |t|
      t.text :description
      t.boolean :is_authorised, default: false

      t.timestamps
    end
  end
end
