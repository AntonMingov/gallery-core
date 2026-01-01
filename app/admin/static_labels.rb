ActiveAdmin.register StaticLabel do
  permit_params :key, :value, :scope, :archived

  index do
    selectable_column
    id_column
    column :key
    column :value
    column :scope
    column :archived
    column :created_at
    actions
  end

  filter :key
  filter :value
  filter :scope
  filter :created_at

  form do |f|
    f.inputs do
      f.input :key, input_html: { disabled: true }
      f.input :value
      f.input :scope, input_html: { disabled: true }
      f.input :archived
    end
    f.actions
  end
end