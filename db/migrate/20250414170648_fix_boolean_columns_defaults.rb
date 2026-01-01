class FixBooleanColumnsDefaults < ActiveRecord::Migration[7.1]
  def change
    execute "UPDATE static_labels SET archived = false WHERE archived IS NULL"

    change_column_default :static_labels, :archived, false
    change_column_null :static_labels, :archived, false

    change_column_null :testimonials, :is_authorised, false
    change_column_null :friends, :is_authorised, false
    change_column_null :categories, :is_authorised, false
  end
end
